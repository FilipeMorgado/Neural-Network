% Imagens vetorizadas numa matriz binaria
pasta = '../res/img/Pasta2/';
[input, tamanho] = tratamento_imagens(pasta);
target = gera_target(tamanho);



%% Simular 'TAM' vezes.
accuracyFinal = 0;
   
%% Criacao da rede e definicao dos seus parametros
%% Topologia (default = 10 neuronios 1 camada)
net = patternnet;
%% Função de ativação
net.layers{1}.transferFcn = 'logsig';
%% Divisão do treino
net.divideFcn = '';
%% Função de Treino
net.trainFcn = 'trainlm';
%% Número de iterações
net.trainParam.epochs = 1000;
%% Treino da rede
net = train(net, input, target);
%view(net);

%% Cálculo de precisão
% Simulacao
pasta = '../res/img/teste/';
input = tratamento_imagens(pasta);
out = sim(net, input);

disp(out)