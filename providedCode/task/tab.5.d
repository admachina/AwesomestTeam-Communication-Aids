'root'[
	'':'\b',
	'environmental'(
		'<-':RESET,
		'NEW-LINE':'\n',
		'NEW-PAGE':NEWPAGE,
		'STATISTICS':STAT,
		'printer'(
			'<-<-':RESET,
			'NULL':NULL,
			'PRINT ON':PRINTON,
			'PRINT OFF':PRINTOFF,
			'NULL':NULL
		)
	),
	'words'[
		'<-':RESET,
		'a - f'(
			'<-<-':RESET,
			'a'(
				'<-<-<-':RESET,
				'A ',
				'ab - al'(
					'<-<-<-<-':RESET,
					'ABOUT ',
					'ADD ',
					'AFRAID ',
					'aft - al'(
						'<-<-<-<-<-':RESET, 'AFTER ', 'AGAIN ', 'ALL ', 'ALONE ')
				),
				'am - ang'(
					'<-<-<-<-':RESET, 'AM ', 'AN ', 'AND ', 'ANGRY '),
				'any - aw'(
					'<-<-<-<-':RESET,
					'ANY ',
					'ARE ',
					'AS ',
					'ask - aw'(
						'<-<-<-<-<-':RESET, 'ASK ', 'AT ', 'AUNT ', 'AWAY ')
				)
			),
			'b - c'(
				'<-<-<-':RESET,
				'ba - bef'(
					'<-<-<-<-':RESET,
					'BABY ',
					'BAD ',
					'BATHROOM ',
					'be - bef'(
						'<-<-<-<-<-':RESET, 'BE ', 'BECAUSE ', 'BED ', 'BEFORE ')
				),
				'bi - by'(
					'<-<-<-<-':RESET,
					'bi - br'(
						'<-<-<-<-<-':RESET, 'BIG ', 'BOY ', 'BRING ', 'BROTHER '),
					'BUT ',
					'BUY ',
					'BY '
				),
				'ca - cle'(
					'<-<-<-<-':RESET,
					'CAN ',
					"CAN'T ",
					'CARE ',
					'carr - cle'(
						'<-<-<-<-<-':RESET, 'CARRY ', 'CHANGE ', 'CHOOSE ', 'CLEAN ')
				),
				'clo - cr'(
					'<-<-<-<-':RESET,
					'CLOSE ',
					'COLD ',
					'COME ',
					'cou - cr'(
						'<-<-<-<-<-':RESET, 'COULD ', 'COUNT ', 'COUSIN ', 'CRY ')
				)
			),
			'd'(
				'<-<-<-':RESET,
				'da - dif'(
					'<-<-<-<-':RESET, 'DAY ', 'DEAD ', 'DID ', 'DIFFERENT '),
				'dir - doc'(
					'<-<-<-<-':RESET, 'DIRTY ', 'DIVIDE ', 'DO ', 'DOCTOR '),
				'doe - doo'(
					'<-<-<-<-':RESET, 'DOES ', 'DONE ', "DON'T ", 'DOOR '),
				'dow - dr'(
					'<-<-<-<-':RESET, 'DOWN ', 'DRESS ', 'DRINK ', 'DRY ')
			),
			'e - f'(
				'<-<-<-':RESET,
				'ea'(
					'<-<-<-<-':RESET, 'EACH ', 'EARLY ', 'EASY ', 'EAT '),
				'em - ex'(
					'<-<-<-<-':RESET,
					'EMPTY ',
					'END ',
					'ENOUGH ',
					'ev - ex'(
						'<-<-<-<-<-':RESET, 'EVEN ', 'EVENING ', 'EVERY ', 'EXCITED ')
				),
				'fa - foo'(
					'<-<-<-<-':RESET,
					'fa'(
						'<-<-<-<-<-':RESET, 'FALL ', 'FAMILY ', 'FAR ', 'FATHER '),
					'FEEL ',
					'FIND ',
					'FOOD '
				),
				'for - fun'(
					'<-<-<-<-':RESET,
					'FOR ',
					'FORWARD ',
					'FRIEND ',
					'fri - fun'(
						'<-<-<-<-<-':RESET, 'FRIDAY ', 'FROM ', 'FULL ', 'FUNNY ')
				)
			)
		),
		'g - n'(
			'<-<-':RESET,
			'g - h'(
				'<-<-<-':RESET,
				'g'(
					'<-<-<-<-':RESET,
					'ga - gi'(
						'<-<-<-<-<-':RESET, 'GAME ', 'GET ', 'GIRL ', 'GIVE '),
					'GO ',
					'GOOD ',
					'GOODBYE '
				),
				'ha - hear'(
					'<-<-<-<-':RESET,
					'HAD ',
					'hap - hav'(
						'<-<-<-<-<-':RESET, 'HAPPY ', 'HARD ', 'HAS ', 'HAVE '),
					'HE ',
					'HEAR '
				),
				'heav - him'(
					'<-<-<-<-':RESET,
					'HEAVY ',
					'HELLO ',
					'HELP ',
					'her - him'(
						'<-<-<-<-<-':RESET, 'HER ', 'HERE ', 'HERS ', 'HIM ')
				),
				'his - hu'(
					'<-<-<-<-':RESET,
					'his - hot'(
						'<-<-<-<-<-':RESET, 'HIS ', 'HOME ', 'HOSPITAL ', 'HOT '),
					'HOUSE ',
					'HOW ',
					'HUNGRY '
				)
			),
			'i - l'(
				'<-<-<-':RESET,
				'I ',
				'i - k'(
					'<-<-<-<-':RESET,
					'IF ',
					'IN ',
					'ing - it'(
						'<-<-<-<-<-':RESET, 'ING ':'\bING ', 'INTO ', 'IS ', 'IT '),
					'j - k'(
						'<-<-<-<-<-':RESET, 'JUST ', 'KEEP ', 'KIND ', 'KNOW ')
				),
				'la - lig'(
					'<-<-<-<-':RESET,
					'la - las'(
						'<-<-<-<-<-':RESET, 'LADY ', 'LAND ', 'LARGE ', 'LAST '),
					'lat - lead'(
						'<-<-<-<-<-':RESET, 'LATE ', 'LAUGH ', 'LAY ', 'LEAD '),
					'lear - let'(
						'<-<-<-<-<-':RESET, 'LEARN ', 'LEAVE ', 'LEFT ', 'LET '),
					'li - lig'(
						'<-<-<-<-<-':RESET, 'LIE ', 'LIFE ', 'LIFT ', 'LIGHT ')
				),
				'lik - ly'(
					'<-<-<-<-':RESET,
					'LIKE ',
					'lit - loo'(
						'<-<-<-<-<-':RESET, 'LITTLE ', 'LONE ', 'LONG ', 'LOOK '),
					'los - lu'(
						'<-<-<-<-<-':RESET, 'LOSE ', 'LOUD ', 'LOVE ', 'LUNCH '),
					'LY ':'\bLY '
				)
			),
			'm'(
				'<-<-<-':RESET,
				'ma - man'(
					'<-<-<-<-':RESET, 'MADE ', 'MAKE ', 'MAN ', 'MANY '),
				'may - mond'(
					'<-<-<-<-':RESET,
					'MAY ',
					'ME ',
					'mea - mis'(
						'<-<-<-<-<-':RESET, 'MEAN ', 'MIDDLE ', 'MINE ', 'MISS '),
					'MONDAY '
				),
				'mone - mos'(
					'<-<-<-<-':RESET, 'MONEY ', 'MORE ', 'MORNING ', 'MOST '),
				'mot - my'(
					'<-<-<-<-':RESET, 'MOTHER ', 'MUCH ', 'MULTIPLY ', 'MY ')
			),
			'n'(
				'<-<-<-':RESET,
				'na - nic'(
					'<-<-<-<-':RESET,
					'NAME ',
					'ne - nev'(
						'<-<-<-<-<-':RESET, 'NEAR ', 'NECESSARY ', 'NEED ', 'NEVER '),
					'NEW ',
					'NICE '
				),
				'NIGHT ',
				'NO ',
				'noo - nu'(
					'<-<-<-<-':RESET, 'NOON ', 'NOT ', 'NOW ', 'NURSE ')
			)
		),
		'o - t'(
			'<-<-':RESET,
			'o'(
				'<-<-<-':RESET,
				'OF ',
				'off - ol'(
					'<-<-<-<-':RESET, 'OFF ', 'OFTEN ', 'OKAY ', 'OLD '),
				'ON ',
				'onl - ov'(
					'<-<-<-<-':RESET,
					'ONLY ',
					'OPEN ',
					'OR ',
					'ot - ov'(
						'<-<-<-<-<-':RESET, 'OTHER ', 'OUR ', 'OUT ', 'OVER ')
				)
			),
			'p - r'(
				'<-<-<-':RESET,
				'pa - pla'(
					'<-<-<-<-':RESET, 'PAIN ', 'PAPER ', 'PEN ', 'PLAY '),
				'ple - pu'(
					'<-<-<-<-':RESET, 'PLEASE ', 'PRETTY ', 'PUSH ', 'PUT '),
				'q'(
					'<-<-<-<-':RESET, 'QUARREL ', 'QUESTION ', 'QUICK ', 'QUIET '),
				'r'(
					'<-<-<-<-':RESET, 'READ ', 'RELATIVE ', 'RIGHT ', 'ROOM ')
			),
			's'(
				'<-<-<-':RESET,
				's - sc'(
					'<-<-<-<-':RESET,
					'S ':'\bS ',
					'sa - sat'(
						'<-<-<-<-<-':RESET, 'SAD ', 'SAID ', 'SAME ', 'SATURDAY '),
					'SAY ',
					'SCHOOL '
				),
				'se - sis'(
					'<-<-<-<-':RESET,
					'SEE ',
					'SEND ',
					'SHE ',
					'sho - sis'(
						'<-<-<-<-<-':RESET, 'SHOULD ', 'SHOW ', 'SICK ', 'SISTER ')
				),
				'sit - sof'(
					'<-<-<-<-':RESET, 'SIT ', 'SLEEP ', 'SO ', 'SOFT '),
				'sor - su'(
					'<-<-<-<-':RESET,
					'SORRY ',
					'SPECIAL ',
					'STAND ',
					'str - su'(
						'<-<-<-<-<-':RESET, 'STOP ', 'STRANGER ', 'SUNDAY ', 'SUPPER ')
				)
			),
			't'(
				'<-<-<-':RESET,
				'ta - tha'(
					'<-<-<-<-':RESET,
					'ta - tele'(
						'<-<-<-<-<-':RESET, 'TABLE ', 'TAKE ', 'TALK ', 'TELEVISION '),
					'TELL ',
					'THANK YOU ',
					'THAT '
				),
				'THE ',
				'them - thu'(
					'<-<-<-<-':RESET,
					'THEM ',
					'then - they'(
						'<-<-<-<-<-':RESET, 'THEN ', 'THERAPIST ', 'THERE ', 'THEY '),
					'THING ',
					'think - thu'(
						'<-<-<-<-<-':RESET, 'THINK ', 'THIS ', 'THROUGH ', 'THURSDAY ')
				),
				'to - tu'(
					'<-<-<-<-':RESET,
					'TO ',
					'tod - tou'(
						'<-<-<-<-<-':RESET, 'TODAY ', 'TOILET ', 'TOMORROW ', 'TOUCH '),
					'TRY ',
					'TUESDAY '
				)
			)
		),
		'u - z, ERASE-WORD'(
			'<-<-':RESET,
			'u - v'(
				'<-<-<-':RESET,
				'un - unt'(
					'<-<-<-<-':RESET, 'UN', 'UNDER ', 'UNDERSTAND ', 'UNTIL '),
				'UP ',
				'ups - us'(
					'<-<-<-<-':RESET, 'UPSET ', 'US ', 'USE ', 'USUAL '),
				'v'(
					'<-<-<-<-':RESET, 'VALUABLE ', 'VERY ', 'VISIT ', 'VISITOR ')
			),
			'wa - wet'(
				'<-<-<-':RESET,
				'wa - war'(
					'<-<-<-<-':RESET, 'WAIT ', 'WALK ', 'WANT ', 'WARM '),
				'was - way'(
					'<-<-<-<-':RESET, 'WAS ', 'WASH ', 'WATER ', 'WAY '),
				'WE ',
				'wed - wet'(
					'<-<-<-<-':RESET,
					'wed - wel'(
						'<-<-<-<-<-':RESET, 'WEDNESDAY ', 'WEEK ', 'WELCOME ', 'WELL '),
					'WENT ',
					'WERE ',
					'WET '
				)
			),
			'wh - wr'(
				'<-<-<-':RESET,
				'wh - whe'(
					'<-<-<-<-':RESET, 'WHAT ', 'WHEELCHAIR ', 'WHEN ', 'WHERE '),
				'whi - why'(
					'<-<-<-<-':RESET, 'WHICH ', 'WHO ', 'WHOSE ', 'WHY '),
				'wi - wom'(
					'<-<-<-<-':RESET, 'WILL ', 'WISH ', 'WITH ', 'WOMAN '),
				'won - wr'(
					'<-<-<-<-':RESET, "WON'T ", 'WORK ', 'WOULD ', 'WRITE ')
			),
			'x - z, ERASE-WORD'(
				'<-<-<-':RESET,
				'ya - yel'(
					'<-<-<-<-':RESET, 'YARD ', 'YEAR ', 'YELL ', 'YELLOW '),
				'YES ',
				'yest - you'(
					'<-<-<-<-':RESET, 'YESTERDAY ', 'YOU ', 'YOUNG ', 'YOUR '),
				'ERASE-WORD':'\w'
			)
		)
	],
	'special symbols'(
		'<-':RESET,
		'. ',
		'? ',
		",  ;  :  '"(
			'<-<-':RESET,
			', ',
			'; ',
			': ',
			"'"
		),
		'arithmetic'[
			'<-<-':RESET,
			'0  1  2  3'(
				'<-<-<-':RESET, '0', '1', '2', '3'),
			'4  5  6  7'(
				'<-<-<-':RESET, '4', '5', '6', '7'),
			'8  9  .  SPACE'(
				'<-<-<-':RESET, '8', '9', '.', 'SPACE':' '),
			'more arithmetic'(
				'<-<-<-':RESET,
				'+  -  *  /'(
					'<-<-<-<-':RESET, '+', '-', '*', '/'),
				'=  (  )  ,'(
					'<-<-<-<-':RESET, '=', '(', ')', ','),
				'<  >  %  $'(
					'<-<-<-<-':RESET, '<', '>', '%', '$'),
				'[  ]  {  }'(
					'<-<-<-<-':RESET,'[', ']', '{', '}')
			)
		]
	),
	'letters'[
		'<-':RESET,
		'SPACE':' ',
		'R  A  I  O'(
			'<-<-':RESET, 'R', 'A', 'I', 'O'),
		'N  T  E  S'(
			'<-<-':RESET, 'N', 'T', 'E', 'S'),
		'more letters'(
			'<-<-':RESET,
			'H',
			'F  M  L  D'(
				'<-<-<-':RESET, 'F', 'M', 'L', 'D'),
			'P  C  U  Y'(
				'<-<-<-':RESET, 'P', 'C', 'U', 'Y'),
			'more letters'(
				'<-<-<-':RESET,
				'B',
				'W',
				'G',
				'more letters'(
					'<-<-<-<-':RESET,
					'J',
					'K',
					'V',
					'more letters'(
						'<-<-<-<-<-':RESET, 'QU', 'X', 'Z', 'restart':RESTART)
				)
			)
		)
	]
]
