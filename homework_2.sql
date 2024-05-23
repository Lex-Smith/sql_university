-- 1. Посчитать количество заказов за все время
SELECT COUNT(*)
FROM public.orders
	
--2. Посчитать сумму по всем заказам за все время (учитывая скидки)
SELECT cast(sum ((unit_price * quantity) - (unit_price * quantity * discount)) as numeric(9,2))
FROM public.order_details
	
--3. Показать сколько сотрудников работает в каждом городе.
SELECT city, count(*)
FROM public.employees
GROUP BY city
	
--4. Выявить самый продаваемый товар в штуках. Вывести имя продукта и его количество.
SELECT pr.product_name, sum(quantity) as "units orderd"
FROM public.order_details od join public.products pr on pr.product_id = od.product_id
GROUP BY pr.product_name
ORDER BY sum(quantity) desc
LIMIT 1
	
--5. Выявить фио сотрудника, у которого сумма всех заказов самая маленькая
SELECT last_name, first_name
FROM employees
WHERE employee_id = 
	(SELECT ord.employee_id
	FROM public.order_details od join public.orders ord on od.order_id = ord.order_id
	GROUP BY ord.employee_id
	ORDER BY sum ((unit_price * quantity) - (unit_price * quantity * discount))
	LIMIT 1
	)	