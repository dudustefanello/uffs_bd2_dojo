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
    and emp.salario = max_dep.avg;

/* 4 */
select dep.nome,
    count(*)
from empregados as emp
join departamentos as dep
    on dep.dep_id = emp.dep_id
group by dep.nome
having count(*) < 3;

/* 5 */
select dep.nome,
    count(*)
from empregados as emp
join departamentos as dep
    on dep.dep_id = emp.dep_id
group by dep.nome
order by count desc;

/* 6 */
select *
from empregados as emp
join empregados as chf
    on chf.emp_id = emp.supervisor_id
where chf.dep_id <> emp.dep_id;

/* 7 */
select dep.nome,
    sum(salario)
from empregados as emp
join departamentos as dep
    on dep.dep_id = emp.dep_id
group by dep.nome;

/* 8 */
with med_dep as (
    select dep.dep_id,
        dep.nome,
        avg(emp.salario)
    from empregados as emp
    join departamentos as dep
        on dep.dep_id = emp.dep_id
    group by dep.dep_id
)
select *
from empregados as emp
join med_dep
    on emp.dep_id = med_dep.dep_id
    and emp.salario > med_dep.avg;