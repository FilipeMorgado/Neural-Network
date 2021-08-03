function alinea_c()
tic;
% Imagens vetorizadas numa matriz binaria

load net_pasta123

pasta = '../res/img/Boas/';
% pasta = '../res/img/Handmade/';
[input, tamanho] = tratamento_imagens(pasta);

target = gera_target(tamanho);

%%load
% load net1.mat


%% Simular 'TAM' vezes.
tam = 1;
accuracyFinalExemplos = 0;

for j=1:tam
    
out = sim(net, input);
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
end

%% Média final
fprintf('\nMedia global final dos [Exemplos] depois de %i testes: %.3f\n', tam, accuracyFinalExemplos/tam);
disp(out);
disp(length(out));
toc;
end
