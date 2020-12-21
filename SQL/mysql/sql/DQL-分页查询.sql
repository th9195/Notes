
# 分页查询
## 语法
	SELECT 列表 FROM 表名
		[WHERE 条件]
		[GROUP BY 分组列名]
		[HAVING 分组后的条件过滤]
		[ORDER BY 排序列名 排序方式]
		LIMIT 开始数据,每页显示的条数;
		
		开始数据 = (当前页数 - 1) * 每页显示的条数

# 每页显示3条数据

# 第1页   开始数据 = (1-1) * 3 = 0
SELECT * FROM product LIMIT 0,3;

# 第2页   开始数据 = (2-1) * 3 = 3
SELECT * FROM product LIMIT 3,3;	
		
# 第3页   开始数据 = (3-1) * 3 = 6		
SELECT * FROM product LIMIT 6,3;























