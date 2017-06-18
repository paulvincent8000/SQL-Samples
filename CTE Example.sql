use Meagastore

; WITH cte_subquery
AS
(
SELECT Market, Customer_ID, ROUND(SUM(Sales) ,0) as [Sales Per Customer]
FROM dbo.Order_View
GROUP BY Market, Customer_ID
)
, cte_query
AS
(
SELECT	Market
		,  ROUND(SUM(Sales),0) AS [Sales by Market]
FROM dbo.Order_View
GROUP BY Market
)

SELECT	cte_query.Market
		, cte_subquery.Market
		, SUM([Sales Per Customer]) AS [Total Sales]
		, AVG([Sales by Market]) AS [Sales by Market]
		, AVG([Sales Per Customer]) AS [Avg Sales by Cust]
FROM cte_subquery
INNER JOIN cte_query
ON cte_query.Market = cte_subquery.Market
GROUP BY cte_query.Market, cte_subquery.Market
