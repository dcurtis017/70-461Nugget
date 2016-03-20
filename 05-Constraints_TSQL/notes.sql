/**
Basic Constraints

1. Null/Not Null
2. Defaults
3. Check - Make sure data being inserted meets a certiain range or pattern of values
4. Unique - A unique non clustered index
5. Primary Key - Allows sql server to uniquely identify roles in table. It is a clustered index
6. Foreign Key


*There can only be one clustered index/table. Data is stored on disk in the order of the clustered index
*Think of clustered indexes as the way phone numbers in the phone book are stored by last name
*Think of unclustered indexes as the index in the back of a book. It's just a pointer to where the data resides

*General rule of thumb is to keep the clustered index small

*identity(1,1) will make sure a number will start at 1 and increment by 1

*to add a default do: column name [null] default('default value')
*named constraint example: discontinuedflag bit not null constraint df_constraint default(0)
*if you don't use a named constraint sql server will name it for you

*default newid() will create a new guid

*unique constraints are technically indexes

*in sql server you can't modify a constraint so you would drop it and add it back with or without a no check constraint 

*For anything with a default you can ommit the column or use the word DEFAULT
*/