# OM-Sieves

![Version](https://img.shields.io/badge/version-BETA-green.svg?style=flat-square) ![License](https://img.shields.io/badge/license-GPL3-blue.svg?style=flat-square) ![Language](https://img.shields.io/badge/language-Lisp-yellow.svg?style=flat-square) 

This library is a complementation of the mathtools developed by Carlos Agon and Moreno Andreatta. It have that aim to make more easy the use of the Xenakis' sieves OM#.

------

It was developed in my Master's Research at Federal University in Juiz de Fora. Financial Support by Federal University in Juiz de Fora.

Esta biblioteca foi desenvolvida em minha pesquisa de mestrado na Universidade Federal de Juiz de Fora. Apoio Financeiro pela Universidade Federal de Juiz de Fora.


![UFJF](https://github.com/charlesneimog/OM-Sieves/blob/master/Imagens/logo.png)

------

_**sieve**_: O objeto sieve faz o próprio crivo. Ele é responsável por dizer qual é o ponto de partida, qual a unidade somatória e o limite. Dele obtemos um self. O self em si não é um resultado, mas um processo. Ou seja, do objeto sieve obtemos somente como fazer o crivo e não o próprio crivo.

__s-union__: No s-union¬ podemos unir dois ou mais crivos. Assim como o objeto sieve¸ este objeto resulta em um self e não em um resultado propriamente dito.

**_s-intersection_**: O s-intersection faz a intersecção de um ou mais crivos. Este objeto também resulta em um self.

**_s-complement_**: Este objeto faz a complementação de um crivo, também resulta em um self. Ou seja, caso temos um crivo de 16 até 32 com o seguinte resultado (16 19 23 25 28 30 31) com este objeto obteremos todos os números de 16 até 32 que não fazem parte do crivo (16 19 23 25 28 30 31). Salientamos que neste objeto alteramos a implementação de Andreatta e Agon. Na implementação deles este objeto resultaria, com o mesmo crivo acima, em todos os números de 0 até 32 e não de 16 até 32. Em nosso uso, esse limite inferior é importante, portanto, alteramos a implementação de modo que o objeto s-complement considere também o limite inferior.

**_Revel-sieve_**: Finalmente, este objeto é responsável por transformar os vários selfs dos objetos acima em números, ele faz a tradução de self para uma lista de números, ele é necessário ao final de toda cadeia de processamento de construção de um crivo.

_**s-union-l**_: Este objeto constrói uma união de crivos a partir de um único objeto, com ele não é necessário criar e conectar vários objetos, facilitando a construção musical, em termos muito diretos, gastar menos tempo conectando objetos. Abaixo temos o exemplo da comparação da construção do mesmo crivo, o da esquerda a partir dos objetos por Carlos Agon e Moreno Andreatta e a direita a partir de nossos objetos.


_**s-intersection-l**_: Este objeto constrói a intersecção de crivos a partir de um único objeto. O objetivo dele é o mesmo que o c-union-l. Abaixo segue a comparação entre os objetos de Andreatta e Agon e nossos objetos.

_**s-perfil**_: Este objeto é responsável por mostrar o perfil de um crivo.

_**s-decompose:**_ Este objeto implementa o conceito descrito em Ariza (2005), ou seja, ele descreve um crivo a partir das uniões necessárias para sua construção. Suponha que estamos analisando uma peça e descobrimos que temos um crivo com os seguintes números: (3 23 33 47 63 70 71 93 95 119 123 143 153 167 174 183 191 213 215 239 243 263 273 278 287 303 311 333 335 359 363 382 383 393 407 423 431 453 455 479 483 486). Com o objeto s-decompose podemos descobrir rapidamente a qual crivo estes números pertencem. 
Esse objeto é útil dentro de nosso processo criando simetrias, ou dando as informações necessárias para criar simetrias a partir de processos randômicos. Ou seja, esteticamente esse processo mostra simetrias onde em um primeiro momento não havia. No exemplo abaixo, temos um patch que busca, em um conjunto de números aleatórios de 16 a 128, aquele conjunto que pode ser representado pela união de 3 ou menos crivos. 

_**s-symmetry-perfil**_: Este objeto busca por crivos simétricos em um terminado espectro de limites. No exemplo abaixo buscaremos simetrias entre limites que vão de 25 até 500 na união dos crivos 1116 e 1916. Na primeira entrada temos os crivos que serão utilizados, na segunda o menor e o maior números de todos os limites testados (testará todos os limites de 25 até 500), e na terceira entrada se estamos trabalhando com união dos crivos na primeira entrada ou com a intersecção dos crivos na primeira entrada, devemos clicar na terceira entrada para mudar as opções ou colocar 1 para união e 2 para intersecção. 
 
_**s-limite**_: Este objeto constrói crivos permitindo trocar o limite deste crivo. Na primeira entrada temos a Unidade Somatória e o Ponto de Partida separada em listas e na segunda entrada temos o limite que será utilizado. 





