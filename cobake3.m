function buahClassifierApp
    % Buat figure untuk GUI
    fig = uifigure('Position', [100, 100, 800, 400], 'Name', 'Buah Classifier');

    % Tambahkan tombol untuk memuat gambar
    btnLoad = uibutton(fig, 'push', 'Position', ...
        [350, 330, 100, 30], 'Text', 'Load Image', 'ButtonPushedFcn', @(btnLoad, event) loadImage());

    % Tambahkan area untuk menampilkan hasil klasifikasi
    lblResult = uilabel(fig, 'Position', [350, 290, 200, 30], 'Text', '');

    % Tambahkan axes untuk menampilkan gambar asli
    axImage = uiaxes(fig, 'Position', [50, 150, 300, 120]);

    % Tambahkan axes untuk menampilkan hasil clustering
    axCluster = uiaxes(fig, 'Position', [450, 150, 300, 200]);

    % Fungsi untuk memuat dan memproses gambar
    function loadImage()
        % Dialog untuk memilih gambar
        [file, path] = uigetfile({'*.jpg;*.jpeg;*.png;*.bmp', 'Image Files (*.jpg, *.jpeg, *.png, *.bmp)'});
        if isequal(file, 0)
            return;
        end
        filename = fullfile(path, file);

        % Baca dan tampilkan gambar asli
        image = imread(filename);
        imshow(image, 'Parent', axImage);

        % Konversi gambar RGB ke HSV
        hsvImage = rgb2hsv(image);

        % Ekstrak komponen H, S, dan V
        h = hsvImage(:,:,1);
        s = hsvImage(:,:,2);
        v = hsvImage(:,:,3);

        % Bentuk array fitur untuk K-means clustering
        features = double([h(:), s(:), v(:)]);

        % Terapkan K-means clustering
        k = 3; % Jumlah cluster
        [clusterIdx, clusterCenters] = kmeans(features, k, 'MaxIter', 1000);

        % Bentuk kembali label cluster ke ukuran gambar asli
        clusteredImage = reshape(clusterIdx, size(h));

        % Tentukan kelas kematangan berdasarkan centroid cluster
        % Mengasumsikan kelas kematangan (1: Matang, 2: Setengah Matang, 3: Mentah)
        matangCluster = mode(clusteredImage((h > 0.872 | h < 0.113) & (s > 0.000 & s < 0.932) & (v > 0.112 & v < 1.000)));
        setengahMatangCluster = mode(clusteredImage((h > 0.063 & h < 0.181) & (s > 0.149 & s < 1.000) & (v > 0.139 & v < 1.000)));
        mentahCluster = mode(clusteredImage((h > 0.254 & h < 0.290) & (s > 0.480 & s < 0.763) & (v > 0.000 & v < 1.000)));

        % Hitung jumlah piksel untuk setiap kelas kematangan
        matangCount = sum(clusteredImage(:) == matangCluster);
        setengahMatangCount = sum(clusteredImage(:) == setengahMatangCluster);
        mentahCount = sum(clusteredImage(:) == mentahCluster);

        [~, maxIndex] = max([matangCount, setengahMatangCount, mentahCount]);

        switch maxIndex
            case 1
                maturity = 'Matang';
            case 2
                maturity = 'Setengah Matang';
            case 3
                maturity = 'Mentah';
        end

        % Tampilkan hasil klasifikasi
        lblResult.Text = ['Kematangan: ', maturity];

        % Tampilkan hasil clustering dalam grafik 3D
        scatter3(axCluster, features(:,1), features(:,2), features(:,3), 5, clusterIdx, 'filled');
        title(axCluster, 'Hasil K-means Clustering');
        xlabel(axCluster, 'Hue');
        ylabel(axCluster, 'Saturation');
        zlabel(axCluster, 'Value');
    end
end
