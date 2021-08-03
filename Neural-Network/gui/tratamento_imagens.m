function [dados, tamanho] = tratamento_imagens(pasta)


diretoria = dir(strcat(pasta, '/*.jpg'));
diretoria = string(natsort({diretoria.name}));
tamanho = length(diretoria);
dados = zeros(1024, tamanho);

% Muda para a pasta das imagens
ultima_pasta = cd(pasta);

for i = 1 : tamanho
    
    % Ler a imagem da pasta
    imagem = imread(diretoria(i));
    imagem = imagem(:,:,1);
    
    % Reduzir o tamanho da imagem
    imagem = imresize(imagem, [32 32]);
    
    % Transformar a imagem numa matriz binária
    imagem = imbinarize(imagem);
    
    % Transforma a matriz numa coluna
    imagem = imagem(:);
    
    % Adiciona a coluna aos dados
    dados(:, i) = imagem;
    
end

% Voltar para a pasta raiz
cd(ultima_pasta);

end
