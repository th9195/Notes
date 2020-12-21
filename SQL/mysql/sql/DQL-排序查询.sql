

# 排序查询

## 语法
SELECT 列名列表 FROM 表名 [WHERE 条件] ORDER BY 列名 排序方式, 列名 排序方式...;

## 排序方式 ASC: 升序(默认)， DESC : 降序
## 如果有多个排序条件，只有当前面的条件值一样时，才会判断第二个条件；

SELECT * FROM product ORDER BY price DESC;

## 查询品牌包含华为的商品信息，并且 降序排序
SELECT * FROM product WHERE brand LIKE '%华为%' ORDER BY price DESC;

## 按照库存升序排序，如果库存一样，按照价格降序排序
SELECT * FROM product ORDER BY stock , price DESC;
















