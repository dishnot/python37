select  B.cust_id, 
        B.fund_id fund_account_id,
        B.account_id account_id,
		'1' side,
		'a' order_type,
        C.order_qty order_qty,
        C.security_id security_id,
        B.market_id market_id,
        B.partition,
        C.price  price 
from  
#证券信息筛选
	(select 
    #a.component_share_qty*100 as order_qty,
	10000*100 as order_qty,
    a.component_security_id as security_id,
    a.market_id market_id,
    b.price_uppper_limit*10000 as price
    from (select *  from tradingconfigdb.t_etf_component_share where data_status>-1 and component_share_qty > 0) a
    inner join tradingconfigdb.t_cash_auction_params b 
    on a.component_security_id = b.security_id and a.market_id=b.market_id
	where  a.security_id = '510020' and component_share_qty>0 ) C   
#账户信息筛选      
INNER JOIN
(select distinct a.cust_id,
        a.account_id,
        a.fund_id,
        a.branch_id,
        a.market_id,
        a.partition,
        a.pbuid
        from basedb.t_accounts a 
		 where a.cust_id='20011631')B 
on B.market_id=C.market_id;