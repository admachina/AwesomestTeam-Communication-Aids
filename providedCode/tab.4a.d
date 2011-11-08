'root'[
	'ERASE-LETTER':'\b',
	'SPACE':' ',
	'E  T  N'(
		'previous letters':RESET, 'E', 'T', 'N', 'auto':NULL),
	'O  A  I'(
		'previous letters':RESET, 'O', 'A', 'I', 'auto':NULL),
	'auto'(
		'previous letters':RESET,
		'R',
		'S',
		'H  D  L'(
			'previous letters':RESET, 'H', 'D', 'L', 'auto':NULL),
		'auto'(
			'previous letters':RESET,
			'M',
			'F',
			'P  C  U'(
				'previous letters':RESET, 'P', 'C', 'U', 'auto':NULL),
			'auto'(
				'previous letters':RESET,
				'Y',
				'G',
				'W',
				'auto'(
					'previous letters':RESET,
					'V',
					'B',
					'X',
					'auto'(
						'previous letters':RESET,
						'QU',
						'K',
						'J',
						'auto'(
							'previous letters':RESET, 'Z', 'NEW-LINE':'\n', '? ? ?':NULL, 'auto':RESTART)
					)
				)
			)
		)
	)
]
