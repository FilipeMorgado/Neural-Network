function feedforward_v2()

% Imagens vetorizadas numa matriz binaria
pasta = '../res/img/Feiosas/';
[input, tamanho] = tratamento_imagens(pasta);
target = gera_target(tamanho);



%% Simular 'TAM' vezes.
tam = 5;
accuracyFinal = 0;
for j=1:tam
   
%% Criacao da rede e definicao dos seus parametros
%% Topologia (default = 10 neuronios 1 camada)
net = fitnet;
%% Função de ativação
net.layers{1}.transferFcn = 'radbasn';
%% Divisão do treino
net.divideFcn = '';
%% Número de iterações
net.trainParam.epochs = 1000;
%% Função de Treino
net.trainFcn = 'trainscg';
%% Treino da rede
net = train(net, input, target);
%view(net);

%% Cálculo de precisão
    % Simulacao
    out = sim(net, input);
    plotconfusion(target, out);
    %%Calcula e mostra a percentagem de classificacoes corretas no total dos exemplos
    r=0;
    for i=1:size(out,2)               % Para cada classificacao  
      [a b] = max(out(:,i));          %b guarda a linha onde encontrou valor mais alto da saida obtida
      [c d] = max(target(:,i));       %d guarda a linha onde encontrou valor mais alto da saida desejada
      if b == d                       % se estao na mesma linha, a classificacao foi correta (incrementa 1)
          r = r+1;
      end
    end
    accuracy = r/size(out,2)*100;
    fprintf('Precisao do teste (%d): %.3f\n', j, accuracy);
    accuracyFinal = accuracyFinal + accuracy;
end

fprintf('Precisao total apos %d testes: %.3f\n', tam, accuracyFinal/tam);


end
