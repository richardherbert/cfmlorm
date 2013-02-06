CFMLORM
======================================================================

Implement dynamic finders and helper methods in CFML ORM (powered by Hibernate), without needing to build concrete classes. 
Started out as an experiment to see if can replicate GORM features in CFML. 

The aim is to build something with no dependencies that can be used with a beanFactory or standalone.

After I started this, Mark Mandel pointed out that he's been working on something similiar in ColdSpring. Being Mark it is going to be awesome! Check it out at:
http://sourceforge.net/apps/trac/coldspring/wiki/ORMAbstractGateway
https://github.com/markmandel/coldspring/blob/develop/coldspring/orm/hibernate/AbstractGateway.cfc

The ColdBox team have an impressive and comprehensive ORM Service layer:
http://wiki.coldbox.org/wiki/Extras:BaseORMService.cfm
https://github.com/ColdBox/coldbox-platform/blob/master/system/orm/hibernate/BaseORMService.cfc

Status
----------------------------------------------------------------------

v0.2
	it works, but hasn't been battle tested. Subject to API changes 
	Use at your own risk :)

Status
----------------------------------------------------------------------

Requirements

Railo 3.3.4 or higher
ColdFusion 9 or higher

Licence
----------------------------------------------------------------------

MIT licence
http://opensource.org/licenses/MIT

Usage
----------------------------------------------------------------------

	// initialise
	Gateway = new model.AbstractGateway( 'Author' );
	
	// delete by ID (returns boolean true / false if deleted)
	Gateway.delete( 1 );
	
	// delete by object (returns boolean true / false if deleted)
	Gateway.delete( obj );
	
	// returns Author object by id. returns null if no match
	Gateway.get( 1 );
	
	// returns array of Author objects. 
	Gateway.getAll();
	
	// returns an array of Author entities matching passed ids. returns empty array of no matches
	Gateway.getAll( [1,3] );

	// returns an array of Author entities
	Gateway.list();
	
	// returns an array of Author entities sorted by name
	Gateway.list( sort="forename" );
	
	// returns an array of Author entities sorted by name descending
	Gateway.list( sort="forename", order="desc" );

	// returns an array of Author entities limited to 5 and offset by 10
	Gateway.list( offset=10, max=5 );
	
	// returns new
	Gateway.new();
	
	// returns new, populated memento
	Gateway.new( memento );

	// returns 1st match as an Author object on forename property
	Gateway.findByForename( 'John' );
	
	// returns 1st match as an Author object on forename and surname property
	Gateway.findByForenameAndSurname( 'John', 'Whish' );
	
	// returns an array of Author entities on forename property
	Gateway.findAllByForename( 'John' );
	
	// returns an array of Author entities on forename and surname properties
	Gateway.findAllByForenameAndSurname( 'John', 'Whish' );
	
	// returns an array of Author entities with an ID between 2 and 5
	Gateway.findAllByIDBetween( 2, 5 );
	
	// returns 1st match as an Author object on forename and surname properties
	Gateway.findByForenameAndSurnameLike( 'J%', 'W%' );
	
	// returns an array of Author entities matching on forename and surname properties
	Gateway.findAllByForenameAndSurnameLike( 'J%', 'W%' );

	// returns 1st match as an Author object on ID property between 2 and 5
	Gateway.findAllByIDBetween( 2, 5 );
	
	// saves Entity (Note - you'll want to wrap in a transaction)
	Gateway.save( object );

