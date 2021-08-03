function feedforward_v1()

% Imagens vetorizadas numa matriz binaria
pasta = './Pasta1/';
input = tratamento_imagens(pasta);



       
%% Criacao da rede e definicao dos seus parametros

net = feedforwardnet; % versão original, com 1 camada escondida
% net = feedforwardnet([5 5]);  % tamanho do vetor = camadas de neuronios
                              % 5 e 10, quantidade de neuronios por camada

%% Função de ativação da camada de saida
% net.layers{3}.transferFcn = 'purelin';
% net.layers{1}.transferFcn = 'tansig'; muda função de ativação dos primeiros 5 neuronios
% net.layers{2}.transferFcn = 'tansig'; muda função de ativação dos segundos 5 neuronios

%% Função de Treino
net.trainFcn = 'trainrp';

%% Usar os exemplos todos no treino
net.divideFcn = '';
% net.divideFcn = 'dividerand';
% net.divideParam.trainRatio = 0.7; % percentagem da amostra que vai para treino
% net.divideParam.valRatio = 0.15;  % percentagem da amostra que vai para validação
% net.divideParam.testRatio = 0.15; % percentagem da amostra que vai para teste

%% Número de épocas
net.trainParam.epochs = 1000;

%% Treino da rede
[net,tr] = train(net, input, target);
view(net);
disp(tr);

% Gravar a rede já treinada
% if not(isfolder('./TrainedNet/'))
%     mkdir('TrainedNet');
% end save('./TrainedNet/net1.mat', 'net');


%% Simulacao
out = sim(net, input);
plotconfusion(target, out);

%% MediasFinais
% globalMedia = 0;
% testeMedia = 0;
% 
% %% Testar tam vezes o setup, para ter uma amostra razoável 
% tam = 5;

%%
% for i=1:tam
% fprintf('Teste %i: \n', i);
%Calcula e mostra a percentagem de classificacoes corretas no total dos exemplos
r=0;
for i=1:size(out,2)               % Para cada classificacao  
  [a b] = max(out(:,i));          %b guarda a linha onde encontrou valor mais alto da saida obtida
  [c d] = max(target(:,i));       %d guarda a linha onde encontrou valor mais alto da saida desejada
  if b == d                       % se estao na mesma linha, a classificacao foi correta (incrementa 1)
      r = r+1;
  end
end

accuracy = r/size(out,2)*100;
fprintf('Precisao total %f\n', accuracy)

%Soma para a média global
% globalMedia = globalMedia + accuracy;

% SIMULAR A REDE APENAS NO CONJUNTO DE TESTE
% TInput = input(:, tr.testInd);
% TTargets = target(:, tr.testInd);

% out = sim(net, TInput);
% 
% %Calcula e mostra a percentagem de classificacoes corretas no conjunto de teste
% r=0;
% for i=1:size(tr.testInd,2)               % Para cada classificacao  
%   [a b] = max(out(:,i));          %b guarda a linha onde encontrou valor mais alto da saida obtida
%   [c d] = max(TTargets(:,i));  %d guarda a linha onde encontrou valor mais alto da saida desejada
%   if b == d                       % se estao na mesma linha, a classificacao foi correta (incrementa 1)
%       r = r+1;
%   end
% end
% accuracy = r/size(tr.testInd,2)*100;
% fprintf('Precisao teste %f\n', accuracy)
% 
% %Soma para a média dos testes
% testeMedia = testeMedia + accuracy;
% end
% 
% %% Média final
% fprintf('\nMedia global final depois de %i testes: %.3f\n', tam, globalMedia/tam);
% fprintf('Media global final depois de %i testes: %.3f\n', tam, testeMedia/tam);


end
