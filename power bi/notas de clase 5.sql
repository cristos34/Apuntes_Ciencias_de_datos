/* Conceptos básicos de DAX en Power BI Desktop

- tablou: maneja sus propias formulas pero es similar  a power binlog


Que es DAX?
es un lenguaje de formulas, maneja algunas limitantes pero nos ayuda a crear informes 
maneja: - expresiones,
        - funciones
		- operadores
        - constantes matematicas 
        

que permite: 
- fecha 
- condicionales y logicas 
- textos
- matematicas y estadistica
- tablas
- variaciones


contexto:
conjunto de circustancias que rodean una situacion y sin las cuales no se puede comprender correctamente , 
(si no comprendemos bajo con contexto operan las funciones de DAX no se puede comprender realmente como van a operar )

Filas
Filtros
Transicion


¿si lo que queremos generar es una columna, una medida o una tabla?
- deacuerdo a lo que generemos es el contexto que va tener


columnas calculadas:
- son parte del modelo de datos
- se calculan fila a fila
- pasan a formar parte de la tabla
- consumo de memoria


medidas calculadas:
- son agregaciones
- son ejecutadas sobre la marcha 
- no forman parte de la tabla 
- consumen CPU adicional 


tablas
- las calculadas
- filtros
- agregaciones
- uniones


Funciones:

- funciones de agregacion: 
opren sobre el concepto de filtro

Variables:

- funcion VAR:
variable con nombre que almacena un resultadoque luego se puede expresar como parametro

Funciones de agregacion X:

funciones de agregacion X:
iteran y se gregan sobre las filas en una tabla, lo mismo que una funcion agregada


Funciones de inteligencia de tiempo:
las funciones de inteligencia de tiempo son extremadamente utiles cuando se trata de inteligencia empresarial y tambien ahorran tiempo al
realizar calculos complejos en funciones simples.
Estas funciones funcionan en campos de fecha y horas para producir una amplia gama de calculos basados en diferentes niveles de periodo de tiempo 

 funciones de texto:
 funcionan en columnas de una tabla para conectar, buscar o manipular la cadena y devolver la totalidad o una parte de una cadena 
 
 funcion de filtro:
 devuleve un subconjunto de la tabla actual en funcion de la exprecion proporcionada y devuelve una tabla como resultado
 
 
 
Medidas rapidas:
 
 


















































