-- Consultas no PySpark

SELECT Produto,
            Categoria,
            ROUND(SUM(Quantidade * Custo),2) AS Valor_SUM
            FROM tb_vendas
            GROUP BY Produto, Categoria
            ORDER BY Valor_SUM DESC;

SELECT Produto,
            ROUND(SUM(Quantidade * Custo),2) AS Valor_SUM
            FROM tb_vendas
            WHERE MONTH(Data_Venda) = 6
            GROUP BY Produto
            ORDER BY Valor_SUM
            LIMIT 5;

-- Consultas no SQLite, com banco de dados normalizado

SELECT p.produto as Produto,
            c.categoria as Categoria,
            ROUND(SUM(r.quantidade * r.custo),2) AS Valor_SUM
            FROM tb_produto AS p
            INNER JOIN tb_categoria AS c
            ON p.id_categoria = c.id
            INNER JOIN tb_registro_venda AS r
            ON p.id = r.id_produto
            GROUP BY Produto, Categoria
            ORDER BY Valor_SUM DESC;

SELECT p.produto as Produto,
            ROUND(SUM(r.quantidade * r.custo),2) AS Valor_SUM
            FROM tb_produto AS p
            INNER JOIN tb_categoria AS c
            ON p.id_categoria = c.id
            INNER JOIN tb_registro_venda AS r
            ON p.id = r.id_produto
            WHERE strftime('%m',r.data_venda) = '06'
            GROUP BY Produto, Categoria
            ORDER BY Valor_SUM
            LIMIT 5;

