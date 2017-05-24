arrayconstant:  IDENTIFIERS LEFTSQUAREBRACKET constant_exp RIGHTSQUAREBRACKET
                {

                };

array:          VAR arrayconstant type
                {

                };

compound:		FUNC type IDENTIFIERS LEFTPARENTHESES formal_arguments 
                RIGHTPARENTHESES LEFTBRACKET statements RIGHTBRACKET
                {

                };

comma_separated_expressions: /*empty*/ | comma_separated_expressions 
                | comma_separated_expressions ',' comma_separated_expressions


function_invocation:	IDENTIFIERS LEFTPARENTHESES comma_separated_expressions RIGHTPARENTHESES


conditional:	IF LEFTPARENTHESES boolean_expr RIGHTPARENTHESES
