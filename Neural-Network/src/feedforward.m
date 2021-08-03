function feedforward()

% Imagens vetorizadas numa matriz binaria
pasta = '../res/img/Pasta2/';
[input, tamanho] = tratamento_imagens(pasta);

target = gera_target(tamanho);

% Criacao da rede e definicao dos seus parametros
net = feedforwardnet;
net.divideFcn = '';
net.trainParam.epochs = 1000;
       
% Treino da rede
net = train(net, input, target);

view(net);

% Gravar a rede já treinada
% if not(isfolder('../net/'))
%     mkdir('../net/');
% end save('../net/net1.mat', 'net');

% Simulacao
out = sim(net, input);

plotconfusion(target, out);

end
