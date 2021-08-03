function teste(topologia, camadas, numeroCamadas, funcaoTreino, caminho)

net = carregaRede(topologia, camadas, numeroCamadas, funcaoTreino, caminho);

[input, tamanho] = tratamento_imagens(caminho);
target = gera_target(tamanho);

[net, tr] =  train(net, input, target);
view(net);

end