% Imagens vetorizadas numa matriz binaria
pasta = '../res/img/Pasta2/';
[input, tamanho] = tratamento_imagens(pasta);
target = gera_target(tamanho);


%% Simular 'TAM' vezes.
tam = 5;
accuracyFinalTestes = 0;
accuracyFinalExemplos = 0;
for j=1:tam
    
%% Topologia (default = 10 neuronios 1 camada)
net = feedforwardnet([5 5 5 5 5 5]);

%% Número de iterações
net.trainParam.epochs = 1000;

%% Função de ativação
net.layers{1}.transferFcn = 'tansig';
net.layers{2}.transferFcn = 'tansig';
net.layers{3}.transferFcn = 'tansig';
net.layers{4}.transferFcn = 'tansig';
net.layers{5}.transferFcn = 'tansig';
net.layers{6}.transferFcn = 'tansig';
net.layers{7}.transferFcn = 'purelin';

%% Divisão do treino
%  net.divideFcn = '';
 net.divideFcn = 'dividerand';
 net.divideParam.trainRatio = 0.7; % percentagem da amostra que vai para treino
 net.divideParam.valRatio = 0.15;  % percentagem da amostra que vai para validação
 net.divideParam.testRatio = 0.15; % percentagem da amostra que vai para teste
%% Função de Treino
net.trainFcn = 'trainlm';

net = train(net, input, target);
%view(net);

%% Treino da rede
[net,tr] = train(net, input, target);
%view(net);

out = sim(net, input);
% save('net1.mat', 'net');
% save net
plotconfusion(target, out);
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
fprintf('Precisao total nos exemplos: %.3f\n', accuracy)
%Soma para a média global
accuracyFinalExemplos = accuracyFinalExemplos + accuracy;

%%SIMULAR A REDE APENAS NO CONJUNTO DE TESTE
TInput = input(:, tr.testInd);
TTargets = target(:, tr.testInd);
out = sim(net, TInput);
%Calcula e mostra a percentagem de classificacoes corretas no conjunto de teste
r=0;
for i=1:size(tr.testInd,2)               % Para cada classificacao  
  [a b] = max(out(:,i));          %b guarda a linha onde encontrou valor mais alto da saida obtida
  [c d] = max(TTargets(:,i));  %d guarda a linha onde encontrou valor mais alto da saida desejada
  if b == d                       % se estao na mesma linha, a classificacao foi correta (incrementa 1)
      r = r+1;
  end
end
accuracy = r/size(tr.testInd,2)*100;
fprintf('Precisao total nos testes: %.3f\n', accuracy)
%Soma para a média dos testes
accuracyFinalTestes = accuracyFinalTestes + accuracy;

end

fprintf('Precisao total apos %d testes: %.3f\n', tam, accuracyFinal/tam);