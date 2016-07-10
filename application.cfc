component extends="framework.one"
{

this.datasource="skiclub";

function setupApplication() {
        var bf = new framework.ioc( "model" );
        setBeanFactory( bf );
    }

}
