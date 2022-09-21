/* 1. Listar os empregados (nomes) que tem salário maior que seu chefe */
select emp.nome as empregado,
    emp.salario as salario_empr,
    chf.nome as chefe,
    chf.salario as salario_chef
from empregados as emp
join empregados as chf
    on chf.emp_id = emp.supervisor_id
where chf.salario < emp.salario;

/* 2. Listar o maior salario de cada departamento (pode ser usado o group by) */
select dep.nome,
    max(emp.salario) as maior_salario
from empregados as emp
join departamentos as dep
    on dep.dep_id = emp.dep_id
group by dep.nome
order by maior_salario desc;

/* 3. Listar o nome do funcionario com maior salario dentro de cada departamento (pode ser usado o IN) */
with max_dep as (
    select dep.dep_id,
        dep.nome,
        max(emp.salario)
    from empregados as emp
    join departamentos as dep
        on dep.dep_id = emp.dep_id
    group by dep.dep_id
)
select emp.nome, emp.salario
from empregados as emp
join max_dep
    on emp.dep_id = max_dep.dep_id
    and emp.salario = max_dep.max;

/* 4. Listar os nomes departamentos que tem menos de 3 empregados; */
select dep.nome
from empregados as emp
join departamentos as dep
    on dep.dep_id = emp.dep_id
group by dep.nome
having count(*) < 3;

/* NÃO TEM 5 */

/* 6. Listar os departamentos  com o número de colaboradores */
select dep.nome,
    count(*) as numero_colabs
from empregados as emp
join departamentos as dep
    on dep.dep_id = emp.dep_id
group by dep.nome
order by numero_colabs desc;

/* 7. Listar os empregados que não possuem chefes no mesmo departamento */
select *
from empregados as emp
join empregados as chf
    on chf.emp_id = emp.supervisor_id
where chf.dep_id <> emp.dep_id;

/* 8. Listar os departamentos com o total de salários pagos */
select dep.nome,
    sum(salario) as total
from empregados as emp
join departamentos as dep
    on dep.dep_id = emp.dep_id
group by dep.nome
order by dep.nome;

/* 9. Listar os colaboradores com salario maior que a média do seu departamento; */
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

/* 10. Compare o salario de cada colaborados com média do seu setor. Dica: usar slide windows functions */
select emp.nome,
    emp.salario,
    dep.nome,
    avg(emp.salario) over (partition by dep.dep_id)
from empregados as emp
join departamentos as dep
    on dep.dep_id = emp.dep_id
group by emp.nome, 
    emp.salario,
    dep.dep_id;

/* 11. Encontre os empregados com salario maior ou igual a média do seu departamento. 
       Deve ser reportado o salario do empregado e a média do departamento */
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
    and emp.salario >= med_dep.avg;

/* QUESTÃO LIVRE:
   Mostrar o total de salários dos supordinados de cada chefe  */
select chf.nome as nome_chefe,
    sum(emp.salario) total_salarios
from empregados as emp
join empregados as chf
    on chf.emp_id = emp.supervisor_id
group by 1
order by 2 desc;

