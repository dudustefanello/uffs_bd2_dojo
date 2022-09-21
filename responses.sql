/* 1 */
select *
from empregados as emp
join empregados as chf
    on chf.emp_id = emp.supervisor_id
where chf.salario < emp.salario;

/* 2 */
select dep.nome,
    max(emp.salario)
from empregados as emp
join departamentos as dep
    on dep.dep_id = emp.dep_id
group by dep.nome;

/* 3 */
with max_dep as (
    select dep.dep_id,
        dep.nome,
        max(emp.salario)
    from empregados as emp
    join departamentos as dep
        on dep.dep_id = emp.dep_id
    group by dep.dep_id
)
select *
from empregados as emp
join max_dep
    on emp.dep_id = max_dep.dep_id
    and emp.salario = max_dep.salario;




select dep.nome, 
    emp.nome,
    max(emp.salario)
from empregados as emp
join departamentos as dep
    on dep.dep_id = emp.dep_id
group by emp.nome,
    dep.nome;
