Meteor.startup ->
	if Tournaments.find().count() is 0
		t1 = {
			name: "Grand Prix Gothenburg"
			startDate: new Date("2013-06-07")
			endDate: new Date("2013-06-09")
			format: "RTR Sealed"
			country: "se"
			type: "gp"
			finished: false
		}

		t2 = {
			name: "Grand Prix Providence"
			startDate: new Date("2013-06-07")
			endDate: new Date("2013-06-09")
			format: "RTR Sealed"
			country: "us"
			type: "gp"
			finished: false
		}

		t3 = {
			name: "Grand Prix Bangkok"
			startDate: new Date("2013-06-21")
			endDate: new Date("2013-06-23")
			format: "RTR Sealed"
			country: "th"
			type: "gp"
			finished: false
		}

		t4 = {
			name: "Grand Prix Calgary"
			startDate: new Date("2013-07-26")
			endDate: new Date("2013-07-28")
			format: "Standard"
			country: "ca"
			type: "gp"
			finished: false
		}

		t5 = {
			name: "Pro Tour Dragon's Maze"
			startDate: new Date("2013-05-17")
			endDate: new Date("2013-05-19")
			format: "RTR Block, Draft"
			country: "us"
			type: "pt"
			finished: true
			standings: [
				"Wescoe, Craig"
				"Castellon, Rob"
				"Mihara, Makihito"
				"Shrout, Andrew"
				"Utter-Leyton, Josh"
				"Zatlkaj, Matej"
				"Ochoa, Dusty"
				"Prost, Andrejs"
				"Duke, Reid"
				"Froehlich, Eric"
				"Scott-Vargas, Luis"
				"Martell, Tom"
				"Nassif, Gabriel"
				"Sharfman, David"
				"Fennell, Chris"
				"Cuenca, Nicolas"
				"Polak-Rottmann, Oliver"
				"Kibler, Brian"
				"Eilers, Mark"
				"Rachid, Denniz"
				"Swift, Orrin"
				"Yim, Chi Hoi"
				"Peleg, Uri"
				"Yukuhiro, Ken"
				"Borba, Rodrigo"
				"Bernat, Michael"
				"Holiday, Nathan"
				"Lax, Ari"
				"Aintrazi, Ali"
				"Swasey, Laurence"
				"Costa, Matthew"
				"Sullivan, Patrick"
				"Dupuy, Alejandro"
				"Juza, Martin"
				"Jurkovic, Robert"
				"Mann, Stephen"
				"Levy, Raphael"
				"Saito, Tomoharu"
				"Yamaguchi, Satoshi"
				"Chapin, Patrick"
				"Nakamura, Shuuhei"
				"Koestler, Jonas"
				"Dezani, Jeremy"
				"Chanpleng, Sethsilp"
				"Oberg, Kenny"
				"Edgerle, Nick"
				"Nordahl, Andreas"
				"Bertiou, Simon"
				"Fehr, Christian"
				"Faeder, Dustin"
				"Cox, Patrick"
				"Wang, Ming Chee"
				"Huang, Hao-Shan"
				"Pranoto, Andreas"
				"Tapia Becerra, Felipe"
				"Jensen, Marten"
				"Muller, Andre"
				"Pirouet, Ian"
				"Klump, Erik"
				"Silva, José Francisco"
				"Cifka, Stanislav"
				"Westling, Tomas"
				"van der Vegt, Jan"
				"DeTora, Melissa"
				"Nezin, Alec"
				"Behrens, Lance"
				"Stroev, Mikhail"
				"Oomori, Ken'ichirou"
				"Budde, Kai"
				"Hobler, Seneca"
				"Portaro, Alessandro"
				"Woods, Conley"
				"Shiraishi, Tomomi"
				"Brown, Alex"
				"Kurth, Lloyd"
				"Stefanescu, Alexandru"
				"Demars, Brian"
				"Nguyen, Richard"
				"Peng, Jianjia"
				"Skarren, Frank"
				"Cantillana, Andrew"
				"Lucy, J. Sawyer"
				"Veenis, Raymond"
				"Liu, Zhuoran"
				"Maher, Robert"
				"La Porta, Alessandro"
				"Bland, Richard"
				"Edwards, Kerry"
				"Ahlberg, Daniel"
				"Mowshowitz, Zvi"
				"Black, Samuel"
				"Merriam, Ross"
				"Nelson, Brad"
				"Vantuch, Mates"
				"Stern, Jon"
				"Kuo, Tzu-Ching"
				"Gushen, Dan"
				"Nass, Matthew"
				"Fehling, Patrick"
				"Potter, Doug"
			]
		}

		Tournaments.insert(t1);
		Tournaments.insert(t2);
		Tournaments.insert(t3);
		Tournaments.insert(t4);
		Tournaments.insert(t5);