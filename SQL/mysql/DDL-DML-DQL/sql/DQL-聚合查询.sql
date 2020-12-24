

# 聚合函数查询
## 聚合函数的介绍

| 函数名      | 功能                             |
| ----------- | -------------------------------- |
| COUNT(列名) | 统计数量（一般选用不为NULL的列） |
| MAX(列名)   | 最大值                           |
| MIN(列名)   | 最小值                           |
| SUM(列名)   | 求和                             |
| AVG(列名)   | 平均值                           |

## 聚合查询的语法
SELECT 函数名称(列名) FROM [WHERE 条件]

## 计算procduct 表中总记录数据
SELECT COUNT(*) FROM product;

## 获取最高价格
SELECT MAX(price) FROM product;

## 获取最低价格
SELECT MIN(price) FROM product;

## 获取总库存数量
SELECT SUM(stock) FROM product;

## 获取品牌为苹果的总库存数量
SELECT SUM(stock) FROM product WHERE brand = '苹果';

## 获取品牌为小米的平均商品价格
SELECT AVG(price) FROM product WHERE brand = '小米';






















