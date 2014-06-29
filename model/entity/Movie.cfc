component persistent=true entityName="Movie" table="movie" {
    property name='id' ormtype='string' length="255" fieldtype='id';
    property name='filepath' ormtype='string' length='255';
    property name='filename' ormtype='string' length='255';
    property name='title' ormtype='string' length='255';
    property name='release_year' ormtype='string' length='255';
    property name='genres' ormtype="string" length="255";
    property name='overview' ormtype='text';
    property name='runtime' ormtype="string" length="255";
    property name='vote_average' ormtype="string" length="255";
}