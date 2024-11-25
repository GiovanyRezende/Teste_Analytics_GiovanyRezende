# Teste Analytics
*Esse projeto é uma análise de um dataset de vendas simulado envolvendo Python, SQL, Pandas, PySpark, Excel e Scikit-Learn para Analytics.* O intuito é aplicar os conhecimentos de análise de dados para extrair insights do dataset.

# Parte 1
A primeira parte se trata de usar o Python para o tratamento inicial dos dados e análises prévias não específicas.

## Parte 1.1
Se trata da limpeza da base de dados de vendas. O dataset foi previamente extraído do Kaggle e inicialmente manipulado no Excel para ser um arquivo ```.csv``` e ter apenas as colunas requisitadas: ID, Data, Produto, Categoria, Quantidade, Preço (este último sendo chamado de Custo no dataset, em referência a "Custo Unitário". 

As ações tomadas nessa etapa foram:
- Adição da coluna *Quantidade* por aleatoriedade usando Numpy;
- Adequação dos dados para conversão de dados necessária;
- Análise de dados nulos ou faltantes;
- Análise da necessidade de remoção de duplicatas.

### O código
Importamos a(s) biblioteca(s) necessária(s), fazemos o input do arquivo ```.csv``` manipulado no Excel para o código do projeto e verificamos os primeiros registros:
```
import pandas as pd
#import numpy as np

df = pd.read_csv('/content/Dados_Comerciais.csv',sep=';',encoding='latin-1')
df.head()
```

Verificamos as informações do dataset para descobrir os tipos de dados que o DataFrame está trabalhando:
```
df.info()
```

Adicionamos a coluna *Quantidade* com Numpy:
```
#Adicionar, por aleatoriedade, a quantidade dos produtos

#Código previamente usado: np.random.randint(1,10,size=len(df.index))
quantities = [6, 8, 3, 9, 5, 4, 4, 3, 1, 6, 8, 2, 9, 2, 7, 2, 3, 3, 5, 4, 6, 7,
       7, 7, 3, 3, 3, 8, 9, 8, 7, 6, 9, 4, 9, 6, 3, 5, 8, 1, 1, 7, 1, 6,
       2, 8, 2, 8, 9, 3, 3, 7, 3, 7, 5, 8, 8, 6, 5, 1, 5, 1, 2, 7, 7, 4,
       8, 5, 1, 2, 9, 8, 6, 9, 5, 3, 7, 6, 4, 5, 4, 2, 5, 7, 7, 4, 4, 5,
       6, 2, 1, 9, 5, 4, 6, 4, 1, 4, 6, 5, 1, 3, 1, 3, 1, 1, 1, 2, 6, 2,
       1, 8, 9, 6, 4, 9, 3, 1, 5, 1, 6, 7, 4, 6, 1, 7, 7, 5, 9, 9, 7, 8,
       1, 1, 9, 3, 6, 1, 6, 7, 7, 8, 8, 9, 8, 7, 2, 5, 8, 4, 2, 2, 6, 7,
       8, 6, 4, 7, 4, 9, 7, 9, 2, 1, 3, 8, 4, 9, 7, 4, 9, 8, 9, 3, 6, 3,
       3, 7, 2, 5, 7, 3, 7, 3, 1, 4, 6, 1, 1, 8, 2, 6, 1, 6, 6, 3, 1, 5,
       2, 9, 7, 4, 3, 2, 5, 8, 5, 7, 3, 2, 7, 2, 3, 2, 4, 1, 6, 4, 1, 8,
       3, 4, 2, 6, 1, 7, 8, 8, 2, 9, 7, 1, 6, 1, 4, 2, 2, 8, 6, 6, 3, 1,
       5, 8, 2, 4, 7, 9, 5, 3, 9, 6, 6, 6, 9, 3, 5, 8, 8, 9, 3, 3, 9, 5,
       3, 4, 6, 7, 3, 9, 9, 9, 6, 6, 9, 9, 8, 4, 2, 7, 7, 4, 4, 7, 4, 7,
       5, 5, 1, 5, 3, 5, 5, 3, 3, 6, 1, 6, 6, 1, 5, 6, 8, 4, 5, 2, 3, 6,
       3, 2, 3, 3, 1, 4, 1, 8, 1, 7, 1, 1, 9, 9, 6, 8, 1, 5, 1, 9, 9, 9,
       2, 5, 1, 6, 2, 9, 5, 3, 7, 7, 9, 8, 4, 2, 5, 2, 2, 2, 4, 6, 5, 5,
       6, 6, 3, 8, 9, 4, 7, 4, 7, 3, 5, 7, 3, 4, 5, 5, 5, 1, 9, 6, 9, 7,
       9, 5, 4, 7, 8, 4, 9, 2, 6, 5, 9, 8, 3, 2, 2, 9, 8, 2, 1, 5, 3, 2,
       6, 4, 8, 1, 9, 9, 6, 9, 8, 9, 5, 9, 6, 9, 7, 9, 6, 3, 3, 7, 6, 2,
       4, 4, 4, 7, 7, 6, 8, 6, 8, 5, 7, 8, 3, 3, 1, 6, 4, 6, 9, 2, 8, 8,
       3, 7, 1, 2, 1, 2, 9, 7, 1, 8, 7, 3, 7, 6, 5, 7, 3]

df['Quantidade'] = pd.Series(quantities)
```

Fazemos as transformações necessárias nos dados, visto que as colunas *ID-Produto* e *Custo* deveriam ser numéricas e a coluna *Data Venda* deveria ser datetime, além de verificarmos os primeiros registros e usarmos ```df.info()``` novamente em uma célula separada para validar a mudança de dados:
```
#Transformação em ID-Produto
df['ID-Produto'] = pd.Series([int(x[4:]) for x in df['ID-Produto']])

#Transformação em Data Venda
df['Data Venda'] = pd.Series([x[:8] + '23' for x in df['Data Venda']])
df['Data Venda'] = pd.to_datetime(df['Data Venda'],dayfirst=True)

#Transformação em Custo
df['Custo'] = df['Custo'].str.replace(',','.').str.replace('R$','')
df['Custo'] = df['Custo'].astype(float)

df.head()
```

Analisamos a quantidade de dados faltantes e/ou nulos:
```
df.isna().sum()
```
```
df.isnull().sum()
```

Por fim, como não houve necessidade de remoção de duplicatas (explicação no PDF, com outras conclusões), criamos o arquivo ```.csv``` com a base de dados limpa:
```
df = df.rename(columns={'Data Venda':'Data_Venda'})
df = df.set_index('ID-Produto')
df.to_csv('data_clean.csv',sep=';')
```

## Parte 1.2
Se trata de uma análise de dados não específica, com o objetivo de extrair padrões e/ou insights.

### O código
Importamos mais bibliotecas necessárias além das prévias, utilizamos agora a base de dados limpa e verificamos os primeiros registros:
```
import matplotlib.pyplot as plt
from sklearn.linear_model import LinearRegression

df = pd.read_csv('/content/data_clean.csv',sep=';')
df['Valor'] = df['Quantidade'] * df['Custo']
df.head()
```

Fazemos uma visualização da soma de vendas por dia ao longo do período:
```
df['Data_Venda'] = pd.to_datetime(df['Data_Venda'])

x = df.sort_values('Data_Venda')['Data_Venda'].unique()
y = df.sort_values('Data_Venda').groupby('Data_Venda')['Valor'].sum()
y = y.reset_index()['Valor']

plt.style.use('Solarize_Light2')
plt.plot(x,y)
plt.title('Relação valor da venda x dia')
plt.xlabel('Dia')
plt.ylabel('Valor da venda')
plt.xticks([])
plt.show()
```
![image](https://github.com/user-attachments/assets/dfaaa590-f7ef-445c-a926-19aafe2d2295)

Utilizamos regressão linear com fins estatísticos (e não necessariamente para ML) de saber a relação da soma de vendas diárias na série temporal:
```
df['Dia'] = (df['Data_Venda'] - pd.to_datetime('2023-01-01')).dt.days
x = df.sort_values('Data_Venda')['Dia'].unique().reshape(-1,1)
y = df.sort_values('Data_Venda').groupby('Data_Venda')['Valor'].sum()
y = y.reset_index()['Valor']

regressao = LinearRegression().fit(x,y)
predicao = regressao.predict(x)

plt.style.use('Solarize_Light2')
plt.plot(x,y)
plt.plot(x,predicao)
plt.title('Relação valor da venda x dia')
plt.xlabel('Dia')
plt.ylabel('Valor da venda')
plt.xticks([])
plt.show()
```
![image](https://github.com/user-attachments/assets/f8532ba2-b27b-42e6-9285-abd976f5f4be)

Analisamos as vendas em cada mês:
```
meses = {'Janeiro':1,'Fevereiro':2,'Março':3,'Abril':4,
         'Maio':5,'Junho':6,'Julho':7,'Agosto':8,
         'Setembro':9,'Outubro':10,'Novembro':11,'Dezembro':12}

plt.style.use('Solarize_Light2')
fig, ax = plt.subplots()
for mes,num in meses.items():
  df_prod = df[df['Data_Venda'].dt.month == num]
  ax.bar(mes,df_prod['Valor'].sum())
  plt.xticks(rotation=90)
ax.set_ylabel("Valor")
ax.set_xlabel("Produto")
plt.title('Relação valor da venda x mês')
plt.show()
```
![image](https://github.com/user-attachments/assets/1eccd301-ed7f-4fef-baca-7e0e0789a0a3)

Analisamos as vendas por categoria de produtos:
```
plt.style.use('Solarize_Light2')
fig, ax = plt.subplots()
for categ in df['Categoria'].unique():
  df_prod = df[df['Categoria'] == categ]
  ax.bar(categ,df_prod['Valor'].sum())
  plt.xticks(rotation=90)
ax.set_ylabel("Valor da venda")
ax.set_xlabel("Categoria")
plt.title('Relação valor da venda x categoria')
plt.show()
```
![image](https://github.com/user-attachments/assets/432f5126-b423-41a5-bfd3-dd9db47b9808)

Analisamos a progressão indívidual de cada categoria na série temporal:
```
plt.style.use('Solarize_Light2')
fig, ax = plt.subplots()
for categ in df['Categoria'].unique():
  df_prod = df[df['Categoria'] == categ]
  x = df_prod.sort_values('Data_Venda')['Data_Venda'].unique()
  y = df_prod.sort_values('Data_Venda').groupby('Data_Venda')['Valor'].sum()
  y = y.reset_index()['Valor']
  ax.plot(x,y)
ax.set_ylabel("Valor da venda")
ax.set_xlabel("Produto")
plt.xticks([])
plt.legend(df['Categoria'].unique())
plt.title('Relação valor da venda x dia por categoria')
plt.show()
```
![image](https://github.com/user-attachments/assets/1afffe14-fa22-4197-baf1-2c02ad4415af)

Fazemos de modo semelhante com as etapas anteriores com a análise da vendas de vendas:
```
x = df.sort_values('Data_Venda')['Data_Venda'].unique()
y = df.sort_values('Data_Venda').groupby('Data_Venda')['Valor'].mean()
y = y.reset_index()['Valor']

plt.style.use('Solarize_Light2')
plt.plot(x,y)
plt.title('Relação valor médio de venda x dia')
plt.xlabel('Dia')
plt.ylabel('Valor médio da venda')
plt.xticks([])
plt.show()
```
![image](https://github.com/user-attachments/assets/b3d1b7e4-c43c-4565-b3d3-6ff64c9604d7)

```
x = df.sort_values('Data_Venda')['Dia'].unique().reshape(-1,1)
y = df.sort_values('Data_Venda').groupby('Data_Venda')['Valor'].mean()
y = y.reset_index()['Valor']

regressao = LinearRegression().fit(x,y)
predicao = regressao.predict(x)

plt.style.use('Solarize_Light2')
plt.plot(x,y)
plt.plot(x,predicao)
plt.title('Relação valor médio de venda x dia')
plt.xlabel('Dia')
plt.ylabel('Valor médio da venda')
plt.xticks([])
plt.show()
```
![image](https://github.com/user-attachments/assets/bf1794ef-6b38-4c72-a4ce-497d222484ba)

Os histogramas na análise de média possuem uma barra de erro que corresponde ao desvio-padrão de cada barra:
```
meses = {'Janeiro':1,'Fevereiro':2,'Março':3,'Abril':4,
         'Maio':5,'Junho':6,'Julho':7,'Agosto':8,
         'Setembro':9,'Outubro':10,'Novembro':11,'Dezembro':12}

plt.style.use('Solarize_Light2')
fig, ax = plt.subplots()
for mes,num in meses.items():
  df_prod = df[df['Data_Venda'].dt.month == num]
  ax.bar(mes,df_prod['Valor'].mean(),yerr=df_prod['Valor'].std())
  plt.xticks(rotation=90)
ax.set_ylabel("Valor média da venda")
ax.set_xlabel("Produto")
plt.title('Relação preço médio de venda x mês')
plt.show()
```
![image](https://github.com/user-attachments/assets/f4ab7b66-fe7f-4a0f-8334-f2994e820f29)

```
plt.style.use('Solarize_Light2')
fig, ax = plt.subplots()
for categ in df['Categoria'].unique():
  df_prod = df[df['Categoria'] == categ]
  ax.bar(categ,df_prod['Valor'].mean(),yerr=df_prod['Valor'].std())
  plt.xticks(rotation=90)
ax.set_ylabel("Valor média da venda")
ax.set_xlabel("Produto")
plt.title('Relação valor médio da venda x categoria')
plt.show()
```
![image](https://github.com/user-attachments/assets/1174a8cb-7211-49f4-9212-aebc65b6fe73)

```
plt.style.use('Solarize_Light2')
fig, ax = plt.subplots()
for categ in df['Categoria'].unique():
  df_prod = df[df['Categoria'] == categ]
  x = df_prod.sort_values('Data_Venda')['Data_Venda'].unique()
  y = df_prod.sort_values('Data_Venda').groupby('Data_Venda')['Valor'].mean()
  y = y.reset_index()['Valor']
  ax.plot(x,y)
ax.set_ylabel("Valor média da venda")
ax.set_xlabel("Produto")
plt.xticks([])
plt.legend(df['Categoria'].unique())
plt.title('Relação valor médio da venda x dia por categoria')
plt.show()
```
![image](https://github.com/user-attachments/assets/cc85c6ad-b465-4631-9d7a-b3fbbd9b8e24)

# Parte 2
Se trata de uma análise de dados específica com SQL. 

As duas análises são:
- Listar o nome do produto, categoria e a soma total de vendas para cada produto, ordenando o resultado pelo valor total de vendas em ordem decrescente;
- Identificar os produtos que venderam menos no mês de junho.

Primeiramente, novamente importamos o dataset para ser analisado e previamente mostrado com PySpark:
```
from pyspark.sql import SparkSession
from pyspark.sql.functions import *

spark = SparkSession.builder.appName("Analytics").getOrCreate()
df = spark.read.csv("/content/data_clean.csv",sep=';',header=True)

df.show()
```

Posteriormente, fazemos a primeira consulta SQL:
```
df.createOrReplaceTempView("tb_vendas")

query = '''SELECT Produto,
            Categoria,
            ROUND(SUM(Quantidade * Custo),2) AS Valor_SUM
            FROM tb_vendas
            GROUP BY Produto, Categoria
            ORDER BY Valor_SUM DESC'''
resultado = spark.sql(query)
resultado.show()
```

Por fim (no PySpark), fazemos a segunda consulta SQL, considerando um número desejado de 5 registros (algo levemente trivial e modificável como desejado):
```
query = '''SELECT Produto,
            ROUND(SUM(Quantidade * Custo),2) AS Valor_SUM
            FROM tb_vendas
            WHERE MONTH(Data_Venda) = 6
            GROUP BY Produto
            ORDER BY Valor_SUM
            LIMIT 5'''
resultado = spark.sql(query)
resultado.show()
```

Se quisermos criar um banco de dados, podemos fazer um Modelo Conceitual e criar o Modelo Físico. Nesse projeto, foi utilizado o SQLite.

Primeiramente, fazemos um Modelo Conceitual para um banco de dados normalizado:


Fazemos o Modelo Lógico no Python usando sqlite3 e o novamente o Pandas como base, utilizando tratamento de exceção para evitar possíveis falhas na criação:
```
import sqlite3

conn = sqlite3.connect('db_vendas.db')
cursor = conn.cursor()

df = pd.read_csv('/content/data_clean.csv',sep=';')

categorias = list(df['Categoria'].unique())
produtos = list(df['Produto'].unique())

try:
  tabela = '''CREATE TABLE IF NOT EXISTS tb_categoria(
    id INT PRIMARY KEY,
    categoria VARCHAR(25) NOT NULL
)'''
  cursor.execute(tabela)
  for i in range(len(categorias)):
    insert = f'''INSERT INTO tb_categoria VALUES ({i+1},'{categorias[i]}')'''
    cursor.execute(insert)
except Exception as e:
  print(f'Erro em Categoria: {e}')
  conn.close()
else:
  try:
    tabela = '''CREATE TABLE IF NOT EXISTS tb_produto(
      id INT PRIMARY KEY,
      produto VARCHAR(100) NOT NULL,
      id_categoria INT NOT NULL,
      CONSTRAINT fk_id_categoria_categoria
      FOREIGN KEY (id_categoria) REFERENCES tb_categoria(id)
  )'''
    cursor.execute(tabela)
    for i in range(len(produtos)):
      categoria = df[df['Produto'] == produtos[i]]['Categoria'].unique()[0]
      id_categoria = categorias.index(categoria) + 1
      insert = f'''INSERT INTO tb_produto
          VALUES ({i+1},'{produtos[i]}',{id_categoria})'''
      cursor.execute(insert)
  except Exception as e:
    print(f'Erro em Produtos: {e}')
    conn.close()
  else:
    try:
      tabela = '''CREATE TABLE IF NOT EXISTS tb_registro_venda(
        id INT PRIMARY KEY,
        id_produto INT NOT NULL,
        data_venda DATE NOT NULL,
        custo FLOAT(6,2) NOT NULL,
        quantidade INT NOT NULL,
        CONSTRAINT fk_id_produto_produto
        FOREIGN KEY (id_produto) REFERENCES tb_produto(id)
        )'''
      cursor.execute(tabela)
      for k,i in df.iterrows():
        id = i['ID-Produto']
        id_produto = produtos.index(i['Produto']) + 1
        data_venda = i['Data_Venda']
        custo = i['Custo']
        quantidade = i['Quantidade']
        insert = f'''INSERT INTO tb_registro_venda
                      VALUES ({id},{id_produto},'{data_venda}',{custo},{quantidade})'''
        cursor.execute(insert)
    except Exception as e:
      print(f'Erro em Registro de Venda: {e}')
      conn.close()
    else:
      conn.commit()
      print("Criação de banco de dados bem sucedida!")
      conn.close()
```

Quando exportamos os dados para um banco de dados, as consultas SQL mudam, pois agora a fonte de dados está normalizada. Com isso, realizamos as novas consultas para SQLite:
```
conn = sqlite3.connect('db_vendas.db')
cursor = conn.cursor()

query = '''SELECT p.produto as Produto,
            c.categoria as Categoria,
            ROUND(SUM(r.quantidade * r.custo),2) AS Valor_SUM
            FROM tb_produto AS p
            INNER JOIN tb_categoria AS c
            ON p.id_categoria = c.id
            INNER JOIN tb_registro_venda AS r
            ON p.id = r.id_produto
            GROUP BY Produto, Categoria
            ORDER BY Valor_SUM DESC'''

df = pd.read_sql_query(query,conn)
df
```
```
conn = sqlite3.connect('db_vendas.db')
cursor = conn.cursor()

query = '''SELECT p.produto as Produto,
            ROUND(SUM(r.quantidade * r.custo),2) AS Valor_SUM
            FROM tb_produto AS p
            INNER JOIN tb_categoria AS c
            ON p.id_categoria = c.id
            INNER JOIN tb_registro_venda AS r
            ON p.id = r.id_produto
            WHERE strftime('%m',r.data_venda) = '06'
            GROUP BY Produto, Categoria
            ORDER BY Valor_SUM
            LIMIT 5'''

df = pd.read_sql_query(query,conn)
df
```

Para finalizar o projeto, fechamos a conexão com o banco de dados:
```
conn.close()
```

# Parte 3
A última parte se trata das conclusões e insights extraídos da análise, estando em anexo nos uploads como um arquivo PDF.



# Contato
<div align=center>

[![logo](https://cdn-icons-png.flaticon.com/256/174/174857.png)](https://br.linkedin.com/in/giovanyrezende)
[![logo](https://images.crunchbase.com/image/upload/c_lpad,f_auto,q_auto:eco,dpr_1/v1426048404/y4lxnqcngh5dvoaz06as.png)](https://github.com/GiovanyRezende)[
![logo](https://logospng.org/download/gmail/logo-gmail-256.png)](mailto:giovanyrmedeiros@gmail.com)
</div>
