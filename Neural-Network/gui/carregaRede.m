function net = carregaRede(topologia, camadas, numeroCamadas, funcaoTreino, caminho)
%% Numero de Neuronios da rede
tam = numeroCamadas - 1;

neuronios = zeros(1, tam);
dados = cell2mat(camadas(1, 1:numeroCamadas, 1));

for i = 1 : tam
   neuronios(i) = dados(i);
end

switch(topologia)
   
    case "FeedForwardNet"
        net = feedforwardnet(neuronios);

    case "CascadeNet"
        net = cascadeforwardnet(neuronios); 
        
    case "PatternNet"
        net = patternnet(neuronios);
        
    case "FitNet"
        net = fitnet(neuronios);
        
end

%% Funcao de Treino da Rede
net.trainFcn = funcaoTreino;

disp(net);

[input, tamanho] = tratamento_imagens(caminho);
target = gera_target(tamanho);

view(net);

disp(target);
disp("");
disp(input);

[net, tr] = train(net, input, target);


end