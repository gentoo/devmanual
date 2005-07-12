# Headers

SRC_URI="http://example.com/files/${P}-core.tar.bz2
		examplecards_foo?  ( http://example.com/files/${P}-foo.tar.bz2 )
		examplecards_bar?  ( http://example.com/files/${P}-bar.tar.bz2 )
		examplecards_baz?  ( http://example.com/files/${P}-baz.tar.bz2 )
		!examplecards_foo? ( !examplecards_bar? ( !examplecards_baz? (
			http://example.com/files/${P}-foo.tar.bz2
			http://example.com/files/${P}-bar.tar.bz2
			http://example.com/files/${P}-baz.tar.bz2 ) ) )"
