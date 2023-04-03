Object subclass: Shape [
    | name |
    <comment: 'base class for all shape classes'>

    <comment: 'create object of shape class'>
    Shape class >> new [
        <category: 'instance creation'>
        | r |
        r := super new.
        r init.
        ^r
    ]

    <comment: 'set name to empty string'>
    init[
        <category: 'intialization'>
	name := ''.
    ]

    setName: objectName[
        name := objectName
    ]

    getName[
        ^name
    ]
]

