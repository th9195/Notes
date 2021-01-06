## JDBC事务管理

- JDBC 如何管理事务
  - 管理事务的功能类: Connection
    - 开启事务:   setAutoCommit(boolean autoCommit); 参数为false:开启事务；
    - 提交事务：commit();
    - 回滚事务:   rollback();