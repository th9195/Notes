

| 符合                | 功能                                  |
| ------------------- | ------------------------------------- |
| >                   | 大于                                  |
| <                   | 小于                                  |
| >=                  | 大于等于                              |
| <=                  | 小于等于                              |
| =                   | 等于                                  |
| <> 或 !=            | 不等于                                |
| BETWEEN ... AND ... | 在某个范围之内（都包含）              |
| IN(...)             | 多选一                                |
| LIKE 占位符         | 模糊查询 _单个任意字符 % 多个任意字符 |
| IS NULL             | 是NULL                                |
| IS NOT NULL         | 不是NULL                              |
| AND 或 &&           | 并且                                  |
| OR 或 \|\|          | 或者                                  |
| NOT 或 !            | 非 ， 不是                            |


# 条件查询
SELECT 列名列表 FROM 表名 WHERE 条件;

## 查询 价格大于5000 的商品信息
SELECT * FROM product WHERE price > 5000;

## 查询品牌为华为的商品信息
SELECT * FROM product WHERE brand = '华为';

## 查询价格在2999 ~ 5999 之间的商品信息
SELECT * FROM product WHERE price BETWEEN 2999 AND 5999;
SELECT * FROM product WHERE price >=2999 AND price <=5999;


## 查询价格为3999,4999 ，5999 的商品信息
SELECT * FROM product WHERE price IN (3999,4999,5999);

## 查询价格不为null 的商品信息
SELECT * FROM product WHERE price IS NOT NULL;
SELECT * FROM product WHERE price IS NULL;


## 查询品牌以 '小' 为开头的商品信息   模糊查询 like
SELECT * FROM product WHERE brand LIKE '小%';

## 查询品牌第二个字是'为'的商品信息
SELECT * FROM product WHERE brand LIKE '_为%';

## 查询名称为3个字符的商品信息
SELECT * FROM product WHERE NAME LIKE '___';

## 查询名称中包含手机的商品信息
SELECT * FROM product WHERE NAME LIKE '%手机%';










