1. $ dbt init 
2. Configuration entrpot de données postgres et base de données dbt_project_final
3. $ dbt build #(test connexion postgres)
4. customization schema staging dans macros
5. $ dbt seed # (csv) error (config dans seed au niveau de dbt_project.yml)
6. $ dbt test #(tester l'unicité et la non nulleté des colonnes host_id et id des deux tables) : host_id non unique dans la table "listings_airbnb_paris"

git config --global user.name SokhnaSy14
git config --global sokhna.a.s.diouf@aims-senegal.org

-KPI 1: Room_Type
$ dbt run -s room_type

























Welcome to your new dbt project!

### Using the starter project

Try running the following commands:
- dbt run
- dbt test


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
