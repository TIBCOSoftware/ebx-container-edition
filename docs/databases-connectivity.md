# Supported databases

This table display all the ebx supported database types.

TODO : mettre seulement ce qu'on supporte

| Chart value type | compatible databases | Driver included by default |
|:-----------------|----------------------|----------------------------|
| postgresql       | PostgreSQL           | yes                        |  
| sqlserver        | SQL Server           | yes                        |  
| h2.standalone    | H2                   | yes                        |  
| oracle           | Oracle               | no                         |
| azure.sql        | Azure SQL            | no                         |
| hana             | Hana                 | no                         |

### Adding new database JDBC driver in the image  

To add another driver that is not include in the ebx image by default please see the [documentation](https://docs.tibco.com/pub/ebx/latest/doc/html/en/ece/customizing_the_image.html#_adding_a_new_jdbc_driver).



 