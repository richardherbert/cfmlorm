component extends="_tests.BaseTestCase" {

	/* ---------------------------- UNIT TESTS ---------------------------- */
	
	function init(){
		assertTrue( getComponentType( CUT ) == "AbstractGateway" );
	}
	
	function delete(){
		var result = CUT.getAll();
		assertTrue( ArrayLen( result ) == 4 );
		transaction{
			var result = CUT.delete( 9999 );
		}
		assertFalse( result );
		transaction {
			var result = CUT.delete( 1 );
		}
		var result = CUT.getAll();
		assertTrue( ArrayLen( result ) == 3 );
		transaction{
			var result = CUT.delete( EntityLoadByPK( "Author", 2 ) );
		}
		var result = CUT.getAll();
		assertEquals( 2, ArrayLen( result ) );
	}
	
	function get(){
		assertTrue( IsNull( CUT.get( 9999 ) ) );
		var result = CUT.get( 1 );
		assertTrue( !IsNull( result ) );
		assertTrue( getComponentType( result ) == "Author" );
		assertEquals( 1, result.getID() );
	}
	
	function getAll(){
		var result = CUT.getAll();
		assertTrue( IsArray( result ) );
		assertTrue( ArrayLen( result ) == 4 );
		var result = CUT.getAll( [1,3] );
		assertTrue( IsArray( result ) );
		assertTrue( ArrayLen( result ) == 2 );
		var result = CUT.getAll( [2] );
		assertTrue( IsArray( result ) );
		assertTrue( ArrayLen( result ) == 1 );
		assertTrue( result[ 1 ].getID() == 2 );
		var result = CUT.getAll( [9999] );
		assertTrue( IsArray( result ) );
		assertTrue( ArrayLen( result ) == 0 );
	}

	function list(){
		var result = CUT.list();
		assertTrue( IsArray( result ) );
		assertTrue( ArrayLen( result ) == 4 );
	}

	function listPaging(){
		var result = CUT.list( offset=1, max=1 );
		assertTrue( IsArray( result ) );
		assertEquals( 1, ArrayLen( result ) );
		assertEquals( 2, result[ 1 ].getID() ); // should be offset by 1
		var result = CUT.list( offset=1, max=2 );
		assertEquals( 2, ArrayLen( result ) );
	}

	function listSort(){
		var resultAsc = CUT.list( sort="forename" );
		var resultDesc = CUT.list( sort="forename", order="desc" );
		assertTrue( IsArray( resultAsc ) );
		assertTrue( IsArray( resultDesc ) );
		assertTrue( ArrayLen( resultAsc ) == 4 );
		assertTrue( ArrayLen( resultDesc ) == 4 );
		assertTrue( resultAsc[ 4 ].getID() == resultDesc[ 1 ].getID() );
	}

	function new(){
		var result = CUT.new();
		assertTrue( getComponentType( result ) == "Author" );
	}
	
	function newPopulate(){
		var memento = { forename="John", surname="Whish" };
		var result = CUT.new( memento );
		assertTrue( getComponentType( result ) == "Author" );
		assertEquals( "John", result.getForename() );
		assertEquals( "Whish", result.getSurname() );
	}
	
	function save( obj ){
		assertEquals( 4, ArrayLen( CUT.list() ) );
		var Author = CUT.new();
		Author.setForename( "Joe" );
		Author.setSurname( "Briggs" );
		Author.setDOB( "2013-01-01" );
		transaction{
			CUT.save( Author );
		}
		assertEquals( 5, ArrayLen( CUT.list() ) );
	}
	
	function findAllBy(){
		var result = CUT.findAllBy( {surname='Whish'} );
		assertTrue( IsArray( result ) );
		assertEquals( 2, ArrayLen( result ) );
		var result = CUT.findAllBy( {forename='John', surname='Whish'} );
		assertTrue( IsArray( result ) );
		assertEquals( 1, ArrayLen( result ) );
		assertTrue( result[ 1 ].getForename() == "John" );
		assertTrue( result[ 1 ].getSurname() == "Whish" );
		var result = CUT.findAllBy( {forename='ZZZZZZ'} );
		assertEquals( 0, ArrayLen( result ) );
	}

	/* -- dynamic methods using onMissingMethod -- */
	function findAllByDynamic(){
		var result = CUT.findAllBySurname( 'Whish' );
		assertTrue( IsArray( result ) );
		assertTrue( ArrayLen( result ) == 2 );
		var result = CUT.findAllByForenameAndSurname( 'John', 'Whish' );
		assertTrue( IsArray( result ) );
		assertTrue( ArrayLen( result ) == 1 );
	}
	
	function findAllIDBetween(){
		var result = CUT.findAllByIDBetween( 1, 3 ); // returns array match between
		assertTrue( IsArray( result ) );
		assertEquals( 3, ArrayLen( result ) );
	}
	
	function findBy(){
		var result = CUT.findBy( {surname='Whish'} );
		assertTrue( getComponentType( result ) == "Author" );
		var result = CUT.findBy( {forename='John', surname='Whish'} );
		assertTrue( getComponentType( result ) == "Author" );
		assertTrue( result.getForename() == "John" );
		assertTrue( result.getSurname() == "Whish" );
		var result = CUT.findBy( {forename='ZZZZZZ'} );
		assertTrue( IsNull( result ) );
	}
	
	function findByDynamic(){
		var result = CUT.findByForename( 'John' );
		assertTrue( getComponentType( result ) == "Author" );
		var result = CUT.findByForenameAndSurname( 'John', 'Whish' );
		assertTrue( getComponentType( result ) == "Author" );
		assertTrue( result.getForename() == "John" );
		assertTrue( result.getSurname() == "Whish" );
		var result = CUT.findByForename( 'ZZZZZZ' );
		assertTrue( IsNull( result ) );
	}
	
	function findByIDBetween(){
		var result = CUT.findByIDBetween( 1, 3 ); // returns 1st match between
		assertTrue( getComponentType( result ) == "Author" );
		assertEquals( 1, result.getID() );
	}
	
	function findByLike(){
		var result = CUT.findByForenameLike( 'J%' );
		assertTrue( getComponentType( result ) == "Author" );
		var result = CUT.findByForenameAndSurnameLike( 'J%', 'W%' );
		assertTrue( getComponentType( result ) == "Author" );
		assertTrue( result.getForename() == "John" );
		assertTrue( result.getSurname() == "Whish" );
	}
	
	function findAllByLike(){
		var result = CUT.findAllBySurnameLike( 'W%' );
		assertTrue( IsArray( result ) );
		assertTrue( ArrayLen( result ) == 2 );
		var result = CUT.findAllByForenameAndSurnameLike( 'J%', '%h' );
		assertTrue( IsArray( result ) );
		assertTrue( ArrayLen( result ) == 1 );
	}
	
	/* ---------------------------- IMPLICIT ---------------------------- */
	
	function beforeTests(){
	}
	function setUp(){
		loadTestData();
		CUT = new model.abstract.AbstractGateway( 'Author' ); 
	}
	function tearDown(){
	}
	function afterTests(){
	}
	
}