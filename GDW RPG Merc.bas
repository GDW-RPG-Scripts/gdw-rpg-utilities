_PALETTECOLOR 1, _RGB32(255, 255, 255)
COLOR 0, 1
'fontpath$ = ENVIRON$("SYSTEMROOT") + "\fonts\LiberationMono-Bold.ttf" 'Find Windows Folder Path.
'fontpath$ = ENVIRON$("SYSTEMROOT") + "\fonts\DroidSansMono.ttf" 'Find Windows Folder Path.
'fontpath$ = ENVIRON$("SYSTEMROOT") + "\fonts\consolab.ttf" 'Find Windows Folder Path.
'fontpath$ = ENVIRON$("SYSTEMROOT") + "\fonts\ARLRDBD.ttf" 'Find Windows Folder Path.
'fontpath$ = "cyberbit.ttf"
'fontpath$ = "consola.ttf"

fontpath$ = "DroidSansMono.ttf"
'fontpath$ = "LiberationMono-Bold.ttf"
style$ = "MONOSPACE, BOLD, ITALIC"
font& = _LOADFONT(fontpath$, 22, style$)
_FONT font&

CLS
RANDOMIZE TIMER
SKILL = 200: SZ = 23: s78 = 78
DIM terrain$(SZ), subtype(SZ), size(SZ), move$(SZ), typ(SZ)
DIM SKILL$(SKILL), skillexp$(SKILL), sample(SKILL), skill(SKILL), alp(SKILL)
DIM DIF$(SKILL, 10), TD$(SKILL, 10), TL$(SKILL, 10), CHAR1$(SKILL, 10), CHAR2$(SKILL, 10)
DIM DESC$(SKILL, 10), DESC2$(SKILL, 10)
DIM sk$(100), sk(100)
RESTORE 40000
FOR I = 1 TO SKILL
    READ SKILL$(I): SKILL$(I) = UCASE$(SKILL$(I))
    IF SKILL$(I) = "END" THEN skillx = I - 1: I = SKILL: GOTO 15
    READ skillexp$(I): SKILL$(I) = UCASE$(SKILL$(I))
    READ sample(I): IF sample(I) = 0 GOTO 15
    FOR J = 1 TO sample(I)
        READ DIF$(I, J), TD$(I, J), TL$(I, J)
        READ CHAR1$(I, J), CHAR2$(I, J)
        READ DESC$(I, J)
        READ DESC2$(I, J)
    15 NEXT
NEXT
DIM cardset$(5)
DIM subcard$(13)
DIM card$(54)

DIM D63(18)
D63(3) = 100.00 '2+
D63(4) = 99.54 '3+
D63(5) = 98.15 '3+
D63(6) = 95.37 '4+
D63(7) = 90.74 '4+
D63(8) = 83.80 '5+
D63(9) = 74.07 '6+
D63(10) = 62.50 '7+
D63(11) = 50.00 '7+
D63(12) = 37.50 '8+
D63(13) = 25.93
D63(14) = 16.20
D63(15) = 9.26
D63(16) = 4.63
D63(17) = 1.85
D63(18) = 0.46

DIM D62(13)
D62(1) = 100
D62(2) = 100
D62(3) = 97.22
D62(4) = 91.67
D62(5) = 83.33
D62(6) = 72.22
D62(7) = 58.33
D62(8) = 41.67
D62(9) = 27.78
D62(10) = 16.67
D62(11) = 8.33
D62(12) = 2.78
D62(13) = 0
GOTO 1
OPEN "Percent.doc" FOR OUTPUT AS #1

FOR I = 3 TO 18 STEP 1
    perc = D63(I): PRINT #1, USING "-## ###%"; 21 - I; perc;
    FOR J = 2 TO 12
        IF D62(J) <= perc THEN PRINT #1, USING "## ###% ##+ Skill - #"; perc - D62(J); D62(J); J; -(J - 8): J = 12
    NEXT
NEXT
CLOSE #1
END
1
sp = 20
PRINT SPC(sp); "G D W  R P G  U t i l i t i e s"
PRINT: PRINT: PRINT: PRINT:
PRINT SPC(sp); "   1. Fast Character Generation"
PRINT
PRINT SPC(sp); "   2. Skill Explanator / Character Database"
PRINT
PRINT SPC(sp); "   3. Animal Generator"
PRINT
PRINT SPC(sp); "   4. GURPS converter"
PRINT
PRINT SPC(sp); "   5. RQ converter"
PRINT
PRINT SPC(sp); "   6. NPC Generation (2300AD)"
PRINT
PRINT SPC(sp); "   7. Monstermaker"
PRINT
PRINT SPC(sp); "   8. Mercenary MARINE Char Gen"
PRINT


GOSUB 1000
CHOICE = VAL(a$): IF CHOICE = 0 THEN RUN

IF CHOICE = 1 THEN GOTO 555: 'SDEIES

IF CHOICE = 3 OR CHOICE = 7 THEN CLS: Animal = 1: GOTO 99: 'Animal
CSKILL = 1
IF CHOICE = 4 THEN CSKILL = 4
IF CHOICE = 5 THEN CSKILL = 5


IF CHOICE = 6 THEN CSKILL = 1: GOTO 9000
IF CHOICE = 8 GOTO 9000

CLS
xx = 15
PRINT SPC(12); " G D W  R P G  S k i l l  E X P L A N A T O R"
PRINT:
PRINT " 0. Your own template"
PRINT
FOR x = 1 TO 20: name$ = STR$(x): name$ = RIGHT$(name$, LEN(name$) - 1) + ".DAT"
    OPEN name$ FOR INPUT AS #1
    I = 0
    INPUT #1, version$, version: CT = version
    INPUT #1, name$
    INPUT #1, character$
    CLOSE #1
    PRINT USING "##. "; x;
    IF LEN(name$) > 19 THEN name$ = LEFT$(name$, 19)
    PRINT name$; SPC(20 - LEN(name$)); character$; version; "       ";
    IF INT(x / 2) = x / 2 THEN PRINT
NEXT
PRINT: INPUT " ", name$:
IF name$ = "0" OR name$ = "" THEN name$ = "GDW RPG Character.DAT": GOTO 55

name$ = name$ + ".DAT": GOTO 55

PRINT: PRINT SPC(xx);: INPUT " ", nam: IF nam > 20 THEN nam = 20

55
OPEN name$ FOR INPUT AS #1
I = 0
INPUT #1, version$, version: CT = version
INPUT #1, name$
INPUT #1, character$

value$ = MID$(character$, 1, 1): GOSUB 50: STRENGTH = value
value$ = MID$(character$, 2, 1): GOSUB 50: DEXTERITY = value
value$ = MID$(character$, 3, 1): GOSUB 50: ENDURANCE = value
value$ = MID$(character$, 4, 1): GOSUB 50: INTELLIGENCE = value
value$ = MID$(character$, 5, 1): GOSUB 50: EDUCATION = value
value$ = MID$(character$, 6, 1): GOSUB 50: SOCIAL = value

INPUT #1, Gender$: a$ = Gender$
Gender$ = "He": gender2$ = "he": gender3$ = "His"
IF a$ = "f" OR a$ = "F" THEN Gender$ = "She": gender2$ = "she": gender3$ = "Her"


JOT = 0
FOR I = 1 TO 100
    INPUT #1, sk$(I), sk(I): IF sk(I) = 0 THEN sk(I) = .2
    PRINT sk$(I); sk(I) * -1
    IF sk$(I) = "Jack-of-all-Trades" OR sk$(I) = "JOT" OR sk$(I) = "Jack-o-T" OR sk$(I) = "Jack of all trades" THEN sk$(I) = "Jack-of-all-Trades"
    PRINT sk$(I); sk(I)
    IF sk$(I) = "Jack-of-all-Trades" THEN JOT = -3 + sk(I)
    IF JOT > 3 THEN JOT = 3
    sk$(I) = UCASE$(sk$(I))
    IF sk$(I) = "END" THEN SkillZ = I - 1: I = 100
NEXT
CLOSE #1
FOR I = 1 TO SKILL
    FOR Z = 1 TO SkillZ
        IF sk$(Z) = SKILL$(I) THEN skill(I) = sk(Z)
    NEXT
NEXT: PRINT skillx; SkillZ
'GOSUB 1000

alp = 0:
IF CSKILL < 4 GOTO 100












































20000 ' Mercenary Char Gen
DIM year$(100), Rank$(20)

'TABLE OF RANKS
'Enlisted Ranks
Rank$(1) = "E1: Private"
Rank$(2) = "E2: Lance Corporal"

'Non-Commissioned Officers (NCO)
Rank$(3) = "E3: Corporal"
Rank$(4) = "E4: Lance Sergeant"
Rank$(5) = "E5: Sergeant"
Rank$(6) = "E6: Gunnery Sergeant"
Rank$(7) = "E7: Leading Sergeant"
Rank$(8) = "E8: First Sergeant"
Rank$(9) = "E9: Sergeant Major"

'Junior Commissioned Officers
Rank$(11) = "01: Second Lieutenant"
Rank$(12) = "02: First Lieutenant"
Rank$(13) = "03: Captain"

'Field Grade Commissoned Officers
Rank$(14) = "04: Major (Marine Force Commander)"
Rank$(15) = "05 : Lieutenant Colonel"
Rank$(16) = "06: Colonel"

'General Officers
Rank$(17) = "07 Brigadier General"
Rank$(18) = "08 Major General"
Rank$(19) = "09 Lieutenant General"
Rank$(20) = "10 General"


GOTO 20399

'Military Occupational Specialty IMOS) Table
'Die Arm
'Roll:    Artillery     Cavalry     Infanty     Marine       Support     Commando

'1        FA Gunner     Vehicle     Gun Cmbt    Gun Cmbt     Vehicle     Gun Cmbt
'2        FA Gunner     Vehicle     Gun Cmbt    Gun Cmbt     Cmbt Eng    Gun Cmbt
'3        Vehicle       Vehicle     HvyWpns     Zero-G       Vehicle     Hvy Wpns
'4        Mechanical    Hvv Wpns    Hvy Wpns    Zero-G       Mechanical  Demolition
'5        Fwd Obs       Hvy Wpns    Vehicle     Hvy Wpns     Electronic  Survival
'6        Computer      Mechanical  Recon       Fwd Obs      Medic       Recon
'7        Electronics   Computer    Vacc Suit   Battle dress Computer    Battle dress

'DM +1 if tech level of world is 12+.



'Army Life      Marine Life     NCO Skills      Cmnd Skills     Staff Skills    Shipboard
'1 Brawling     Brawling        HVYWpns         +1 Endur        Mechanic        Fwd Obs
'2 +1 Str       Gambling        Mechanic        Gun Cmbt        Fwd Obs         Ships Boat
'3 Gambling     +1 Str          Tactics         Vehicle         Computer        Gunnery
'4 +1 Dex       +1 Dex          Hvy Wpns        Hvy Wpns        Electronics     Vacc Suit
'5 +1 Endur     +1 Endur        Mechanical      Leader          Medical         Gunnery
'6 +1 Endur     +1 Blade        Tactics         Tactics         Instruction     Vace Suit
'7 +1 Pistol    +1 Educ         Leader          Tactics         Admin
'8 +1 Soc       +1 Soc          Leader          Leader          Admin
'9 +1 Soc       +1 Soc          Admin
'10                             Instruction
'11                             Admin

'DMs :
'Army Life, Marine Life +1 if junior commissioned officer; +2 if field grade officer; +3 if general officer.
'NCO Skills : +I if sergeant; +2 if gunnery sergeant: +3 if leading sergeant: +4 if first sergeant; +5 if sergeant major.
'Command Skills, Staff Skills: +1 if field grade officer; +2 it general officer.
'Shipboard: No DMs.




'General Assignment


'Roll:    Artillery     Cavalry     lnfantry    Marine      Support     Commando

'0        Command       Command     Command     Command     Command     Command
'1        Command       Command     Command     Command     Command     Command
'2        Command       Command     Command     Command     Staff       Command
'3        Staff         Command     Command     Command     Staff       Command
'4        Staff         Staff       Staff       Staff       Staff       Command
'5        Staff         Staff       Staff       Staff       Staff       Staff
'6        Special       Special     Special     Special     Special     Special
'7        Special       Special     Special     Special     Special     Special

'Note: All except officers treat staff and command results as unit assignment.
'DM'S:If Education 8+, DM+3 allowed. Officer may elect DM - 1 (buckingfor command).

'Special Assignments
'Die Roll:  Enlisted And NCO's      Officers
'1          Cross Trng              Intelligence School
'2          Specialist School       Command College
'3          Commando School         Staff College
'4          Protected forces        Commando School
'5          Recruiting              Recruiting
'6          OCS                     Military AttachelAide
'7          OCS

'DM'S: Marine enlisted and NCO's may add one if Educ 7+, Army enlisted men and
'NCO's may add one if endur 7+.














20100
'REM Artillery

'Roll:    Artillery

'1        FA Gunner
'2        FA Gunner
'3        Vehicle
'4        Mechanical
'5        Fwd Obs
'6        Computer
'7        Electronics


IF roll = 2 THEN UAS$ = "Raid"
IF roll = 3 THEN UAS$ = "Trng"
IF roll = 4 THEN UAS$ = "Ctr Ins"
IF roll = 5 THEN UAS$ = "Pol Act"
IF roll = 6 THEN UAS$ = "Garr"
IF roll = 7 THEN UAS$ = "Garr"
IF roll = 8 THEN UAS$ = "Garr"
IF roll = 9 THEN UAS$ = "Trng"
IF roll = 10 THEN UAS$ = "Pol Act"
IF roll = 11 THEN UAS$ = "Ctr Ins"
IF roll = 12 THEN UAS$ = "Trng"


20200
'Cavalry
IF roll = 2 THEN UAS$ = "Raid"
IF roll = 3 THEN UAS$ = "Trng"
IF roll = 4 THEN UAS$ = "Ctr Ins"
IF roll = 5 THEN UAS$ = "Pol Act"
IF roll = 6 THEN UAS$ = "Garr"
IF roll = 7 THEN UAS$ = "Garr"
IF roll = 8 THEN UAS$ = "Garr"
IF roll = 9 THEN UAS$ = "Trng"
IF roll = 10 THEN UAS$ = "Pol Act"
IF roll = 11 THEN UAS$ = "Intl Sec"
IF roll = 12 THEN UAS$ = "Pol Act"

20300
'Infantry
IF roll = 2 THEN UAS$ = "Raid"
IF roll = 3 THEN UAS$ = "Raid"
IF roll = 4 THEN UAS$ = "Ctr Ins"
IF roll = 5 THEN UAS$ = "Ctr Ins"
IF roll = 6 THEN UAS$ = "Garr"
IF roll = 7 THEN UAS$ = "Garr"
IF roll = 8 THEN UAS$ = "Garr"
IF roll = 9 THEN UAS$ = "Trng"
IF roll = 10 THEN UAS$ = "Pol Act"
IF roll = 11 THEN UAS$ = "Intl Sec"
IF roll = 12 THEN UAS$ = "Intl Sec"




20399 year = 0
20400 'Marine

year = year + 1
character$ = ""
value = STRENGTH: GOSUB 60: character$ = character$ + value$
value = DEXTERITY: GOSUB 60: character$ = character$ + value$
value = ENDURANCE: GOSUB 60: character$ = character$ + value$
value = INTELLIGENCE: GOSUB 60: character$ = character$ + value$
value = EDUCATION: GOSUB 60: character$ = character$ + value$
value = SOCIAL: GOSUB 60: character$ = character$ + value$

IF year > 2 THEN CLS: PRINT 18 + year; ", "; Rank$(Rank); " "; character$: PRINT
IF INT(year / 4) = year / 4 THEN PROSTOP = 0
IF year = 1 THEN year$(1) = "Basic Training, Gun Combat": sk$(1) = "Gun Combat": sk(1) = 1: Tskill = 1: GOTO 20400
IF year > 2 THEN GOTO 20410
year$(2) = "Advanced Training"
DM = 0: IF tl > 11 THEN DM = 1
roll = INT(RND * 6) + 1 + DM
'Marine MOS
IF roll = 1 THEN skill$ = "Gun Combat"
IF roll = 2 THEN skill$ = "Gun Combat"
IF roll = 3 THEN skill$ = "Zero-G"
IF roll = 4 THEN skill$ = "Zero-G"
IF roll = 5 THEN skill$ = "Heavy Weapons"
IF roll = 6 THEN skill$ = "Forward Observer"
IF roll = 7 THEN skill$ = "Battle Dress"
GOTO 20455


20410
IF EDUCATION > 7 THEN DM = 3
IF Rank > 10 THEN DM = -1
roll = INT(RND * 6) + 1 + DM

IF roll < 4 THEN GA$ = "Command"
IF roll = 4 OR roll = 5 THEN GA$ = "Staff"
IF roll > 5 THEN GA$ = "Special"
IF Rank < 10 AND roll < 6 THEN GA$ = "Unit"

'Note: All except officers treat staff and command results as unit assignment.
'DM'S:If Education 8+, DM+3 allowed. Officer may elect DM - 1 (buckingfor command).

IF GA$ <> "Special" GOTO 20420

UAS$ = GA$

'Special Assignments
'Die Roll:  Enlisted And NCO's  Officers
'1          Cross Trng          Intelligence School
'2          Specialist School   Command College
'3          Commando School     Staff College
'4          Protected forces    Commando School
'5          Recruiting          Recruiting
'6          OCS                 Military AttachelAide
'7          OCS
'DM'S: Marine enlisted and NCO's may add one if Educ 7+, Army enlisted men and NCO's may add one if endur 7+.

IF Rank > 10 GOTO 20415
'Special Assignments
'Die Roll:  Enlisted And NCO's
roll = INT(RND * 6) + 1
IF EDUCATION > 7 THEN roll = roll + 1
IF roll = 1 THEN SA$ = "Cross Training": GOTO 204101
IF roll = 2 THEN SA$ = "Specialist School": GOTO 204102
IF roll = 3 THEN SA$ = "Commando School": GOTO 204103
IF roll = 4 THEN SA$ = "Protected forces": GOTO 204104
IF roll = 5 THEN SA$ = "Recruiting": GOTO 204105
IF roll > 5 THEN SA$ = "OCS, commission to O1: Second Lieutnant": Rank = 11



year$(year) = SA$: GOTO 20456

'DM'S: Marine enlisted and NCO's may add one if Educ 7+, Army enlisted men and NCO's may add one if endur 7+.

204101
'1. Cross-Training: The player rolls once on the MOS table of any other service arm than his own.
'He further notes that he has been cross-trained in that arm.  'Neither army nor marine personnel may cross-train
'as commandoes. Army personnel may not cross train as marines. At the conclusion af any term after a player has
'cross-trained in another arm, and provided the player successfullrj- reenlists, the player may switch to that arm,
'Thus while the only combat arm that a marine may 'initially enter is infantry, it is possible to transfer into
'cavalry or artillery through cross-training.
year$(year) = SA$

GOTO 20456

204102
'2. Specialist School: The player has been chosen to receive specialist training in a specific field. The player rolls
'a single six-sided die and receives one level of expertise in the indicated skill.

year$(year) = "Specialist School: "

roll = INT(RND * 6) + 1 + DM

IF roll = 1 THEN skill$ = "Admin"
IF roll = 2 THEN skill$ = "Medical"
IF roll = 3 THEN skill$ = "Commo"
IF roll = 4 THEN skill$ = "Computer"
IF roll = 5 THEN skill$ = "Mechanical"
IF roll = 6 THEN skill$ = "Electronics"
GOSUB 20800

year$(year) = SA$ + ", " + skill$
GOTO 20456

204103 Commando = 1
'3. Commando School: The player has been chosen Specialist School to attend Commando School and receive Commando basic training.
'The player may receive up to eight skills as a result. Roll 5+ on one die for each of the following 8 skills:
'Brawling, Gun Combat, Demolitions, Wilderness Survival, Recon, Vacc Suit, Blade Combat and Instruction.
'Marine commando trainees are not required to make a saving throw against marine tradition to avoid
'the onus of taking Blade skill in Cutlass expertise. At the conclusion of any term after a player has attended
'Commando School, and provided the player successtully reenlists, the player may transfer to the commando arm.
year$(year) = SA$
roll = INT(RND * 6) + 1
IF roll > 4 THEN skill$ = "Brawling": GOSUB 20800
roll = INT(RND * 6) + 1
IF roll > 4 THEN skill$ = "Gun Combat": GOSUB 20800
roll = INT(RND * 6) + 1
IF roll > 4 THEN skill$ = "Demolitons": GOSUB 20800
roll = INT(RND * 6) + 1
IF roll > 4 THEN skill$ = "Survival": GOSUB 20800
roll = INT(RND * 6) + 1
IF roll > 4 THEN skill$ = "Recon": GOSUB 20800
roll = INT(RND * 6) + 1
IF roll > 4 THEN skill$ = "Vacc Suit": GOSUB 20800
roll = INT(RND * 6) + 1
IF roll > 4 THEN skill$ = "Blade Combat": GOSUB 20800
roll = INT(RND * 6) + 1
IF roll > 4 THEN skill$ = "Instruction": GOSUB 20800

GOTO 20456



204104
'4. Protected Forces Training: Protected forces are those which operate in a naturally hostile environment,
'such as a vacuum. The player may acquire up to two skills. Roll 3+ on one die for each of the following: Vacc Suit, Zero-G Combat.

year$(year) = "Protected Forces Training"

roll = INT(RND * 6) + 1
IF roll > 2 THEN skill$ = "Vacc-Suit": GOSUB 20800
roll = INT(RND * 6) + 1
IF roll > 2 THEN skill$ = "Zero-G": GOSUB 20800

GOTO 20456

204105
'5 Recruiting: The player has been assigned to a recruiting station and receives an automatic recruiting skill.
year$(year) = "Recruiting Station"

roll = INT(RND * 6) + 1
skill$ = "Recruiting": GOSUB 20800
GOTO 20456


'6. OCS: The player has been sent to Officer Candidate School. Roll one command skill, one staff skill,
'and one additional MOS in the player's arm of service. Following completion of the assignment. the player is
'given a commission as a second lieutenant.

GOTO 20421

20415
'Special Assignments
'Die Roll:  Officers
roll = INT(RND * 6) + 1
IF roll = 1 THEN SA$ = "Intelligence School": GOTO 204151
IF roll = 2 THEN SA$ = "Command College": GOTO 204152
IF roll = 3 THEN SA$ = "Staff College": GOTO 204153
IF roll = 4 THEN SA$ = "Commando School": GOTO 204154
IF roll = 5 THEN SA$ = "Recruiting": GOTO 204105
IF roll = 6 THEN SA$ = "Military Attache/Aide": GOTO 204156

year$(year) = SA$: GOTO 20456

204151
'1. Intelligence School: The officer has been sent to Intelligence School and may receive up to four skills.
'Roll 4+ (one one die] for each of the following: Forgery, Bribery, Streetwise, and Interrogation.
year$(year) = SA$ + " "
roll = INT(RND * 6) + 1
IF roll > 3 THEN skill$ = "Forgery": GOSUB 20800
roll = INT(RND * 6) + 1
IF roll > 3 THEN skill$ = "Brawling": GOSUB 20800
roll = INT(RND * 6) + 1
IF roll > 3 THEN skill$ = "Streetwise": GOSUB 20800
roll = INT(RND * 6) + 1
IF roll > 3 THEN skill$ = "Interrogation": GOSUB 20800

GOTO 20456




204152
'2. Command College: The officer has been posted to Command College and may acquire up to three skills.
'Roll 4+ (on one die) for each of the following: Tactics, Leadership, and Recon.
year$(year) = SA$ + " "
roll = INT(RND * 6) + 1
IF roll > 3 THEN skill$ = "Tactics": GOSUB 20800
roll = INT(RND * 6) + 1
IF roll > 3 THEN skill$ = "Leadership": GOSUB 20800
roll = INT(RND * 6) + 1
IF roll > 3 THEN skill$ = "Recon": GOSUB 20800
GOTO 20456


204153
'3. Staff College: The officer has been posted t o Staff Coilege and may acquire up to three skills.
'Roll 4+ on one die for each of the following: Admin, Combat Engineering, Computer.
year$(year) = SA$ + " "
roll = INT(RND * 6) + 1
IF roll > 3 THEN skill$ = "Admin": GOSUB 20800
roll = INT(RND * 6) + 1
IF roll > 3 THEN skill$ = "Combat Engineering": GOSUB 20800
roll = INT(RND * 6) + 1
IF roll > 3 THEN skill$ = "Computer": GOSUB 20800
GOTO 20456



204154
'4. Commando School: The officer has been posted to Commando School. Commando training
'is the same for officers as it is for enlisted men and NCO's.
GOTO 204103


'5. Recruiting: The officer has been posted to a recruiting station and receives an automatic recruiting skill.
GOTO 204105

204156
roll = INT(RND * 6) + 1
IF roll < 5 THEN Rank = Rank + 1: SOCIAL = SOCIAL + 1: SA$ = "Military Attachee": GOTO 20456
SA$ = "Military Aide": SOCIAL = SOCIAL + 1: Aide = 1

'6. Military Attache/Aide: The player rolls a single die. On a roll of 1-4 he has been assigned
'as a military attache and receives an automatic promotion of one grade and +1 social level.
'On a roll of 5-6 he has been assigned as an aide to a general officer.
'He receives +1 social level and may choose his next assignment, selecting either command position,
'or any special assignment other than military attachelaide.
GOTO 20456


GOTO 20421






20420
roll = INT(RND * 6) + INT(RND * 6) + 2

IF roll = 2 THEN UAS$ = "Raid"
IF roll = 3 THEN UAS$ = "Raid"
IF roll = 4 THEN UAS$ = "Ctr Ins"
IF roll = 5 THEN UAS$ = "Intl Sec"
IF roll = 6 THEN UAS$ = "Shp Trp"
IF roll = 7 THEN UAS$ = "Garr"
IF roll = 8 THEN UAS$ = "Shp Trp"
IF roll = 9 THEN UAS$ = "Trng"
IF roll = 10 THEN UAS$ = "Ctr Ins"
IF roll = 11 THEN UAS$ = "Pol Act"
IF roll = 12 THEN UAS$ = "Pol Act"

20421
UAX$ = UAS$
IF UAS$ = "Ctr Ins" THEN UAX$ = "Counter Insurgency"
IF UAS$ = "Garr" THEN UAX$ = "Garrison Duty"
IF UAS$ = "Trng" THEN UAX$ = "Training Assignment"
IF UAS$ = "Pol Act" THEN UAX$ = "Police Action"
IF UAS$ = "Intl Sec" THEN UAX$ = "Internal Security"
SA$ = UAX$


'Assignment Resolution

'Marine:
'           Training    Intl Sec    Pol Act     Ctr Ins     Raid    Ships Trps
'Survival   auto        4+          5+          5+          6+      4+
'Decoration none        12+         8+          9+          5+      12+
'Promotion  (6+)        (6+)        8+          9+          6+      (6+)
'Skills      7+         none        7+          8+          5+      6+

'-DMs: For survival, DM +1 allowed if any MOS skill level is 2 ox greater.
'For promotion, DM +1 allowed if education 7+.
'-Marines in garrison use the infantry garrison column.

'Reenlist   6+

'Army enlisted men and NCO's receive a DM of +2. Marine personnel who have been
'cross-trained in artillery or cavalry and announce their intention to either
'that arm of service upon reenlistment receive a DM of +I


'Commando:
'           Training   Int'l Sec   Pol Act     Ctr Ins     Raid    Garrison
'Survival    3+         4+          4+          5+          6+      auto
'Decoration none        none        9+          8+          5+      none
'Promotion  (8+)        (7+)        8+          7+          6+      (9+)
'Skills      6+         none        7+          6+          5+      none

'-DMs: For survival, DM +1 allowed for any MOS skill level 2 or greater.
'For promotion, DM +I if endurance &+.






IF UAS$ = "Trng" THEN Survival = 0: Decoration = 99: Promotion = 6.1: SkillR = 7
IF UAS$ = "Intl Sec" THEN Survival = 4: Decoration = 12: Promotion = 6.1: SkillR = 99
IF UAS$ = "Pol Act" THEN Survival = 5: Decoration = 8: Promotion = 8: SkillR = 7
IF UAS$ = "Ctr Ins" THEN Survival = 5: Decoration = 9: Promotion = 9: SkillR = 8
IF UAS$ = "Raid" THEN Survival = 6: Decoration = 5: Promotion = 6: SkillR = 5
IF UAS$ = "Shp Trp" THEN Survival = 4: Decoration = 12: Promotion = 6.1: SkillR = 6
IF UAS$ = "Garr" THEN Survival = 0: Decoration = 99: Promotion = 7.1: SkillR = 99
IF PROSTOP = 1 THEN Promotion = 99
UAX$ = UAS$
IF UAS$ = "Ctr Ins" THEN UAX$ = "Counter Insurgency"
IF UAS$ = "Garr" THEN UAX$ = "Garrison Duty"
IF UAS$ = "Trng" THEN UAX$ = "Training Assignment"
IF UAS$ = "Pol Act" THEN UAX$ = "Police Action"
IF UAS$ = "Intl Sec" THEN UAX$ = "Internal Security"
IF UAS$ = "Shp Trp" THEN UAX$ = "Ships Troops"



year$(year) = UAX$
CLS
PRINT " "; character$; " "; Rank$(Rank): PRINT
FOR x = 1 TO year: PRINT USING "  ##."; x + 17;: PRINT " "; year$(x): NEXT

IF GA$ = "Special" GOTO 20451
'Survival

roll = INT(RND * 6) + INT(RND * 6) + 2 + survDM
IF roll >= Survival THEN GOTO 20429
CLS
PRINT " Your character died in character generation, get yourself a T-shirt.": PRINT
PRINT " You rolled a"; roll; "but needed a"; Survival; "+.": PRINT
FOR x = 1 TO year: PRINT USING "##."; x + 17;: PRINT " "; year$(x): NEXT
PRINT
GOSUB 20700

GOSUB 1000: RUN



20429
IF UAS$ = "Trng" OR UAS$ = "Intl Sec" OR UAS$ = "Shp Trp" OR UAS$ = "Garr" GOTO 20430
IF roll = Survival THEN purple = purple + 1: PRINT " Your character is wounded and recieves a Purple Heart!": year$(year) = year$(year) + ", PH":

20430 'Decoration
roll = INT(RND * 6) + INT(RND * 6) + 2
IF roll < Decoration GOTO 20440
IF roll >= Decoration + 6 THEN PRINT " SEH Starburst for extreme heroism": seh = seh + 1: year$(year) = year$(year) + ", SEH": GOTO 20440
IF roll >= Decoration + 3 THEN PRINT " MCG Medal of cospicious gallantry": mcg = mcg + 1: year$(year) = year$(year) + ", MCG": GOTO 20440
PRINT " MCUF Meritorious conduct under Fire": mcuf = mcuf + 1: year$(year) = year$(year) + ", MCUF":

20440 'Promotion
roll = INT(RND * 6) + INT(RND * 6) + 2
IF Rank > 10 AND INT(Promotion) <> Promotion GOTO 20450
IF EDUCATION > 6 THEN roll = roll + 1
IF roll >= INT(Promotion) THEN Rank = Rank + 1: PRINT: PRINT " PROMOTED to "; Rank$(Rank): year$(year) = year$(year) + ", " + Rank$(Rank): PRINT
IF Rank > 10 THEN PROSTOP = 1

20450 'SKILLS
roll = INT(RND * 6) + INT(RND * 6) + 2
IF roll < SkillR THEN GOTO 20456




20451
PRINT
PRINT " Choose a skill area"
PRINT
PRINT " Marine (L)ife, (M)OS";
IF GA$ = "Command" THEN PRINT ", (C)ommand";
IF GA$ = "Staff" THEN PRINT ", (S)taff";
IF Rank > 2 AND Rank < 10 THEN PRINT ", (N)CO";
IF UAS$ = "Shp Trp" THEN PRINT ", Ships (T)roops";
PRINT "."

GOSUB 1000
IF a$ = "L" THEN GOSUB 20461: GOTO 20455
IF a$ = "M" THEN GOSUB 20462: GOTO 20455
IF a$ = "C" THEN GOSUB 20463: GOTO 20455
IF a$ = "S" THEN GOSUB 20464: GOTO 20455
IF a$ = "N" THEN GOSUB 20465: GOTO 20455
IF a$ = "T" THEN GOSUB 20466: GOTO 20455
GOTO 20451

20455 GOSUB 20800
'year$(year) = year$(year) + ", " + skill$

'PRINT " "; TSkill; Skills;: FOR x = 1 TO TSkill: PRINT Sk$(x); " ";: NEXT: PRINT



20456 IF year < 3 GOTO 20400
PRINT
PRINT " "; GA$; " assignment, "; SA$
PRINT
PRINT " End of year: ";: GOSUB 20700
PRINT: PRINT " Press X to end career."

GOSUB 1000: IF a$ = "X" THEN GOTO 9100: name$ = Rank$(Rank): GOTO 9100
GOTO 20400

20460 'SKILLS


20461 'Marine Life

'Marine Life +1 if junior commissioned officer; +2 if field grade officer; +3 if general officer.
IF Rank > 10 AND Rank < 14 THEN DM = 1
IF Rank > 13 AND Rank < 17 THEN DM = 2
IF Rank > 16 THEN DM = 3
roll = INT(RND * 6) + 1 + DM
IF roll = 1 THEN skill$ = "Brawling"
IF roll = 2 THEN skill$ = "Gambling"
IF roll = 3 THEN skill$ = "+1 Str": STRENGTH = STRENGTH + 1
IF roll = 4 THEN skill$ = "+1 Dex": DEXTERITY = DEXTERITY + 1
IF roll = 5 THEN skill$ = "+1 Endur": ENDURANCE = ENDURANCE + 1
IF roll = 6 THEN skill$ = "Blade"
IF roll = 7 THEN skill$ = "+1 Educ": EDUCATION = EDUCATION + 1
IF roll = 8 THEN skill$ = "+1 Soc": SOCIAL = SOCIAL + 1
IF roll = 9 THEN skill$ = "+1 Soc": SOCIAL = SOCIAL + 1


RETURN

'
20462
'Marine MOS

IF tech > 11 THEN DM = 1
roll = INT(RND * 6) + 1 + DM
survDM = 1
IF roll = 1 THEN skill$ = "Gun Combat"
IF roll = 2 THEN skill$ = "Gun Combat"
IF roll = 3 THEN skill$ = "Zero-G"
IF roll = 4 THEN skill$ = "Zero-G"
IF roll = 5 THEN skill$ = "Heavy Weapons"
IF roll = 6 THEN skill$ = "Forward Observer"
IF roll = 7 THEN skill$ = "Battle Dress"
'DM +1 if tech level of world is 12+.
RETURN

20463

'Command
DM = 0
IF Rank > 13 AND Rank < 17 THEN DM = 1
IF Rank > 16 THEN DM = 2

roll = INT(RND * 6) + 1 + DM

IF roll = 1 THEN skill$ = "+1 Endur"
IF roll = 2 THEN skill$ = "Gun Combat"
IF roll = 3 THEN skill$ = "Vehicle"
IF roll = 4 THEN skill$ = "Heavy Weapons"
IF roll = 5 THEN skill$ = "Leader"
IF roll = 6 THEN skill$ = "Tactics"
IF roll = 7 THEN skill$ = "Tactics"
IF roll = 8 THEN skill$ = "Leader"
'+1 if field grade officer; +2 it general officer.
RETURN


20464
'Command Skills, Staff Skills: +1 if field grade officer; +2 it general officer.
'Staff
DM = 0
IF Rank > 13 AND Rank < 17 THEN DM = 1
IF Rank > 16 THEN DM = 2

roll = INT(RND * 6) + 1 + DM


IF roll = 1 THEN skill$ = "Mechanic"
IF roll = 2 THEN skill$ = "Forward Observer"
IF roll = 3 THEN skill$ = "Computer"
IF roll = 4 THEN skill$ = "Electronics"
IF roll = 5 THEN skill$ = "Medical"
IF roll = 6 THEN skill$ = "Instruction"
IF roll = 7 THEN skill$ = "Admin"
IF roll = 8 THEN skill$ = "Admin"
''+1 if field grade officer; +2 it general officer.
RETURN


20465
'NCO Skills
IF Rank > 3 THEN DM = 1
IF Rank > 5 THEN DM = 2
IF Rank > 6 THEN DM = 3
IF Rank > 7 THEN DM = 4
IF Rank > 8 THEN DM = 5

roll = INT(RND * 6) + 1 + DM
IF roll = 1 THEN skill$ = "Heavy Weapons"
IF roll = 2 THEN skill$ = "Mechanic"
IF roll = 3 THEN skill$ = "Tactics"
IF roll = 4 THEN skill$ = "Heavy Weapons"
IF roll = 5 THEN skill$ = "Mechanic"
IF roll = 6 THEN skill$ = "Tactics"
IF roll = 7 THEN skill$ = "Leader"
IF roll = 8 THEN skill$ = "Leader"
IF roll = 9 THEN skill$ = "Admin"
IF roll = 10 THEN skill$ = "Instruction"
IF roll = 11 THEN skill$ = "Admin"
sk$(Tskill) = skill$

'NCO S kills: +1 if sergeant; +2 if gunnery sergeant: +3 if leading sergeant: +4 if first sergeant, +5 if sergeant major.
RETURN

20466
'Shipboard skills
roll = INT(RND * 6) + 1

IF roll = 1 THEN skill$ = "Forward Observer"
IF roll = 2 THEN skill$ = "Ships Boat"
IF roll = 3 THEN skill$ = "Gunnery"
IF roll = 4 THEN skill$ = "Vacc Suit"
IF roll = 5 THEN skill$ = "Gunnery"
IF roll = 6 THEN skill$ = "Vacc Suit"
RETURN


20467
'Commando skills
roll = INT(RND * 6) + 1
IF tech > 11 THEN roll = roll + 1

IF roll = 1 THEN skill$ = "Gun Combat"
IF roll = 2 THEN skill$ = "Gun Combat"
IF roll = 3 THEN skill$ = "Heavy Weapons"
IF roll = 4 THEN skill$ = "Demolitions"
IF roll = 5 THEN skill$ = "Survival"
IF roll = 6 THEN skill$ = "Recon"
IF roll = 7 THEN skill$ = "Battle dress"

RETURN



20500
'Support
IF roll = 2 THEN UAS$ = "Raid"
IF roll = 3 THEN UAS$ = "Intl Sec"
IF roll = 4 THEN UAS$ = "Ctr Ins"
IF roll = 5 THEN UAS$ = "Garr"
IF roll = 6 THEN UAS$ = "Garr"
IF roll = 7 THEN UAS$ = "Garr"
IF roll = 8 THEN UAS$ = "Garr"
IF roll = 9 THEN UAS$ = "Trng"
IF roll = 10 THEN UAS$ = "Pol Act"
IF roll = 11 THEN UAS$ = "Intl Sec"
IF roll = 12 THEN UAS$ = "Pol Act"


20600
'Commando
IF roll = 2 THEN UAS$ = "Raid"
IF roll = 3 THEN UAS$ = "Raid"
IF roll = 4 THEN UAS$ = "Ctr Ins"
IF roll = 5 THEN UAS$ = "Pol Act"
IF roll = 6 THEN UAS$ = "Intl Sec"
IF roll = 7 THEN UAS$ = "Garr"
IF roll = 8 THEN UAS$ = "Trng"
IF roll = 9 THEN UAS$ = "Trng"
IF roll = 10 THEN UAS$ = "Ctr Ins"
IF roll = 11 THEN UAS$ = "Raid"
IF roll = 12 THEN UAS$ = "Raid"


20700 'Skill check
'PRINT Sk$(TSkill); Sk(TSkill);

FOR a = 1 TO Tskill
    PRINT sk$(a); " -"; sk(a);
NEXT
PRINT
RETURN


'GOSUB 1000


20800 Noskill = 0
FOR a = 1 TO Tskill
    sk$(a) = UCASE$(sk$(a))
    IF sk$(a) = UCASE$(skill$) THEN sk(a) = sk(a) + 1: Noskill = 1
NEXT
IF Noskill = 1 THEN GOTO 208001
Tskill = Tskill + 1: sk$(Tskill) = skill$: sk(Tskill) = 1
208001
year$(year) = year$(year) + ", " + skill$
RETURN








































6000
'GURPS & RQ Conversion

GST = INT(STRENGTH * 1.5)
GDX = INT(DEXTERITY * 1.5)
GIQ = INT(INTELLIGENCE * 1.5): IF CHOICE = 5 THEN GIQ = INTELLIGENCE + 6
GHT = INT(ENDURANCE * 1.5)
GSI = STRENGTH + 6
COSI = GHT + GSI

6001 'Thrust
IF GST < 5 THEN wd = 0: DM = 0: GOTO 6021
IF GST = 5 THEN wd = 1: DM = -5: GOTO 6021
IF GST = 6 THEN wd = 1: DM = -4: GOTO 6021
IF GST = 7 THEN wd = 1: DM = -3: GOTO 6021
IF GST = 8 THEN wd = 1: DM = -3: GOTO 6021
IF GST = 9 THEN wd = 1: DM = -2: GOTO 6021
IF GST = 10 THEN wd = 1: DM = -2: GOTO 6021
rf = GST - 11
wd = INT(rf / 8) + 1: DM = ((rf / 8 - wd + 1) * 4 - 1)
6021
td = CINT(wd): tm = INT(DM)
thrust = td * 3.5 + tm

7001 'Swing
IF GST < 5 THEN wd = 0: DM = 0: GOTO 7021
IF GST = 5 THEN wd = 1: DM = -5: GOTO 7021
IF GST = 6 THEN wd = 1: DM = -4: GOTO 7021
IF GST = 7 THEN wd = 1: DM = -3: GOTO 7021
IF GST = 8 THEN wd = 1: DM = -2: GOTO 7021
IF GST = 9 THEN wd = 1: DM = -1: GOTO 7021
IF GST = 10 THEN wd = 1: DM = 0: GOTO 7021
IF GST > 9 THEN rf = GST - 9
wd = INT(rf / 4) + 1: DM = CINT((rf / 4 - wd + 1) * 4 - 1)
7021
SD = CINT(wd): SM = CINT(DM)
swing = SD * 3.5 + SM

Speed = (GHT + GDX) / 4
Dodge = INT(Speed + 3)

AP0 = GIQ + GDX
AP = CINT(AP0 / 12)
HR = CINT(GHT / 6)
SR = (GDX + GIQ) / 2

damod = GST + GSI
damod$ = "-1D8"
IF damod > 5 THEN damod$ = "-1D6"
IF damod > 10 THEN damod$ = "-1D4"
IF damod > 15 THEN damod$ = "-1D2"
IF damod > 20 THEN damod$ = ""
IF damod > 25 THEN damod$ = "+1D2"
IF damod > 30 THEN damod$ = "+1D4"
IF damod > 35 THEN damod$ = "+1D6"
IF damod > 40 THEN damod$ = "+1D8"
IF damod > 45 THEN damod$ = "+1D10"



Loc$ = "Head 1 Chest 3 Abdomen 2 Arms 1 Legs 1": LO$ = "13311"
IF COSI > 5 THEN Loc$ = "Head 2 Chest 4 Abdomen 3 Arms 1 Legs 2": LO$ = "24312"
IF COSI > 10 THEN Loc$ = "Head 3 Chest 5 Abdomen 4 Arms 2 Legs 3": LO$ = "35423"
IF COSI > 15 THEN Loc$ = "Head 4 Chest 6 Abdomen 5 Arms 3 Legs 4": LO$ = "46534"
IF COSI > 20 THEN Loc$ = "Head 5 Chest 7 Abdomen 6 Arms 4 Legs 5": LO$ = "57645"
IF COSI > 25 THEN Loc$ = "Head 6 Chest 8 Abdomen 7 Arms 5 Legs 6": LO$ = "68756"
IF COSI > 30 THEN Loc$ = "Head 6 Chest 8 Abdomen 7 Arms 5 Legs 6": LO$ = "79867"
IF COSI > 35 THEN Loc$ = "Head 6 Chest 8 Abdomen 7 Arms 5 Legs 6": LO$ = "8A967"
IF COSI > 40 THEN Loc$ = "Head 6 Chest 8 Abdomen 7 Arms 5 Legs 6": LO$ = "9BA78"
IF COSI > 45 THEN Loc$ = "Head 6 Chest 8 Abdomen 7 Arms 5 Legs 6": LO$ = "ACB89"
IF COSI > 50 THEN Loc$ = "Head 6 Chest 8 Abdomen 7 Arms 5 Legs 6": LO$ = "BDC9A"
IF COSI > 55 THEN Loc$ = "Head 6 Chest 8 Abdomen 7 Arms 5 Legs 6": LO$ = "CEDAB"
IF COSI > 60 THEN Loc$ = "Head 6 Chest 8 Abdomen 7 Arms 5 Legs 6": LO$ = "DFEBC"

FOR Z = 1 TO 5
    value$ = MID$(LO$, Z, 1): GOSUB 50
    IF Z = 1 THEN Head = value
    IF Z = 2 THEN Chest = value
    IF Z = 3 THEN Abdomen = value
    IF Z = 4 THEN Arms = value
    IF Z = 5 THEN Legs = value


NEXT



CLS
IF CHOICE = 5 GOTO 7500
IF nnn = 1 GOTO 7401
PRINT " "; name$; " "; character$
PRINT
PRINT " GURPS Conversion"
PRINT
PRINT USING " ST:## DX:## IQ:## HT:##"; GST; GDX; GIQ; GHT
PRINT USING " Thrust##D+#  Swing##D+#"; td; tm; SD; SM
PRINT USING " Speed###.##  Dodge ####"; Speed; Dodge
PRINT: GOTO 7600
7401
PRINT #nnn,
PRINT #nnn,
PRINT #nnn, "G U R P S  Conversion"
PRINT #nnn,
PRINT #nnn, USING "ST:## DX:## IQ:## HT:##"; GST; GDX; GIQ; GHT
PRINT #nnn, USING "Thrust##D+#  Swing##D+#"; td; tm; SD; SM
PRINT #nnn, USING "Speed###.##  Dodge ####"; Speed; Dodge
PRINT #nnn,: GOTO 7600

7500
IF nnn = 1 GOTO 7501
PRINT " "; name$; " "; character$
PRINT
PRINT " R U N E Q U E S T  Conversion"
PRINT
PRINT USING " STR## DEX## CON## SIZ## INT##"; GST; GDX; GHT; GSI; GIQ
PRINT USING " Action ##  Heal ##  Strike ##"; AP; HR; SR
IF damod$ <> "" THEN PRINT " Damage Modifier "; damod$
PRINT
PRINT USING "  ##   "; Head
PRINT USING "## # # "; Arms; Chest; Arms
PRINT USING "  ##   "; Abdomen
PRINT USING " ## #   "; Legs; Legs
'PRINT " "; Loc$
PRINT
GOTO 7600

7501
PRINT #nnn,
PRINT #nnn,
PRINT #nnn, "R U N E Q U E S T  Conversion"
PRINT #nnn,
PRINT #nnn, USING "STR## DEX## CON## SIZ## INT##"; GST; GDX; GHT; GSI; GIQ
PRINT #nnn, USING "Action ##  Heal ##  Strike ##"; AP; HR; SR
IF damod$ <> "" THEN PRINT #nnn, "Damage Modifier "; damod$
PRINT #nnn,
PRINT #nnn,
PRINT #nnn, USING "Head      ##   "; Head
PRINT #nnn,
PRINT #nnn, USING "Chest  ## ## ## "; Arms; Chest; Arms
PRINT #nnn,
PRINT #nnn, USING "Abdomen   ##   "; Abdomen
PRINT #nnn,
PRINT #nnn, USING "Legs    ##  ##   "; Legs; Legs
'PRINT " "; Loc$
PRINT #nnn,
PRINT #nnn,
7600
'GOSUB 1000

FOR rate = 10 TO -1 STEP -1
    FOR a1 = 65 TO 90
        FOR a2 = 65 TO 90
            ALPH$ = CHR$(a1) + CHR$(a2): ' PRINT a1; a2; ALPH$,: GOSUB 1000
            FOR I = 1 TO SKILL
                IF INT(skill(I)) <> rate GOTO 1710
                IF ALPH$ <> LEFT$(SKILL$(I), 2) THEN GOTO 1710
                IF skill(I) < .1 THEN skill(I) = -3 + JOT: GOTO 1710

                SKILL$(I) = UCASE$(SKILL$(I)): 'PRINT skill$(i);: GOSUB 1000
                'text$ = SKILL$(I) + STR$(INT(skill(I)) * -1): GOSUB 19999
                'text$ = skillexp$(I): GOSUB 19999: PRINT

                IF sample(I) = 0 GOTO 1710
                FOR J = 1 TO 1
                    target = 8
                    char1$ = CHAR1$(I, J)
                    IF char1$ = "STR" THEN value = STRENGTH: GOSUB 800
                    IF char1$ = "DEX" THEN value = DEXTERITY: GOSUB 800
                    IF char1$ = "END" THEN value = ENDURANCE: GOSUB 800
                    IF char1$ = "INT" THEN value = INTELLIGENCE: GOSUB 800: IF Animal = 1 THEN modi = 0
                    IF char1$ = "EDU" THEN value = EDUCATION: GOSUB 800: IF Animal = 1 THEN modi = 0
                    IF char1$ = "SOC" THEN value = SOCIAL: GOSUB 800
                    char1 = modi

                    char2$ = CHAR2$(I, J)
                    IF char2$ = "STR" THEN value = STRENGTH: GOSUB 800
                    IF char2$ = "DEX" THEN value = DEXTERITY: GOSUB 800
                    IF char2$ = "END" THEN value = ENDURANCE: GOSUB 800
                    IF char2$ = "INT" THEN value = INTELLIGENCE: GOSUB 800: IF Animal = 1 THEN modi = 0
                    IF char2$ = "EDU" THEN value = EDUCATION: GOSUB 800: IF Animal = 1 THEN modi = 0
                    IF char2$ = "SOC" THEN value = SOCIAL: GOSUB 800
                    char2 = modi

                    charX = char1: IF char2 > charX THEN charX = char2
                    IF CT = 1 THEN charX = 0
                    modi = charX + INT(skill(I))
                    target = target - charX - INT(skill(I))
                    tx = target
                    IF tx > 12 THEN tx = 12
                    IF tx < 2 THEN tx = 2
                    percent = D62(tx)
                    GOSUB 50100
                    IF nnn = 1 GOTO 1702

                    IF CHOICE = 4 THEN PRINT " "; SKILL$(I);: PRINT USING "-##"; GURPS
                    IF CHOICE = 5 THEN PRINT " "; SKILL$(I); SPC(20 - LEN(SKILL$(I)));: PRINT USING "###%"; rq
                    GOTO 1703

                    1702
                    IF CHOICE = 4 THEN PRINT #nnn, SKILL$(I);: PRINT #nnn, USING "-##"; GURPS
                    IF CHOICE = 5 THEN PRINT #nnn, SKILL$(I); SPC(20 - LEN(SKILL$(I)));: PRINT #nnn, USING "###%"; rq

                    1703
                    'PRINT target; modi
                NEXT
            1710 NEXT
        NEXT
    NEXT
NEXT
IF nnn = 1 THEN RETURN
GOSUB 1000
RUN
50100
IF target < 0 THEN GURPS = 21: rq = 120
IF target = 0 THEN GURPS = 20: rq = 110
IF target = 1 THEN GURPS = 19: rq = 105
IF target = 2 THEN GURPS = 18: rq = 100
IF target = 3 THEN GURPS = 16: rq = 95
IF target = 4 THEN GURPS = 14: rq = 90
IF target = 5 THEN GURPS = 13: rq = 85
IF target = 6 THEN GURPS = 12: rq = 75
IF target = 7 THEN GURPS = 11: rq = 60
IF target = 8 THEN GURPS = 9: rq = 45
IF target = 9 THEN GURPS = 8: rq = 30
IF target = 10 THEN GURPS = 7: rq = 15
IF target = 11 THEN GURPS = 6: rq = 10
IF target = 12 THEN GURPS = 4: rq = 5
RETURN

D62(1) = 100
D62(2) = 100
D62(3) = 97.22
D62(4) = 91.67
D62(5) = 83.33
D62(6) = 72.22
D62(7) = 58.33
D62(8) = 41.67
D62(9) = 27.78
D62(10) = 16.67
D62(11) = 8.33
D62(12) = 2.78
D62(13) = 0


8000 'NPC 2300
cardset$(1) = "of Clubs"
cardset$(2) = "of Diamonds"
cardset$(3) = "of Hearts"
cardset$(4) = "of Spades"
cardset$(5) = "of Jokers"


subcard$(1) = "Ace"
subcard$(2) = "Two"
subcard$(3) = "Three"
subcard$(4) = "Four"
subcard$(5) = "Five"
subcard$(6) = "Six"
subcard$(7) = "Seven"
subcard$(8) = "Eight"
subcard$(9) = "Nine"
subcard$(10) = "Ten"
subcard$(11) = "Jack"
subcard$(12) = "Queen"
subcard$(13) = "King"


FOR I = 1 TO 4
    FOR J = 1 TO 13
        card$((I - 1) * 13 + J) = subcard$(J) + " " + cardset$(I)
    NEXT
NEXT
card$(53) = "Joker"
card$(54) = "JOKER"

'FOR I = 1 TO 54: PRINT card$(I); " ";: NEXT:


8010
card = INT(54 * RND) + 1: subcard = 0

IF card < 14 THEN suite = 1: subcard = 0: Suite$ = "Clubs": GOTO 8020

IF card < 27 THEN suite = 2: subcard = -13: Suite$ = "Diamond": GOTO 8020

IF card < 40 THEN suite = 3: subcard = -26: Suite$ = "Hearts": GOTO 8020

IF card < 53 THEN suite = 4: subcard = -39: Suite$ = "Spades": GOTO 8020

suite = 5: subcard = -52: Suite$ = "Joker": GOTO 8020

8020 card = card + subcard
IF suite = 1 GOTO 8050
IF suite = 2 GOTO 8060
IF suite = 3 GOTO 8070
IF suite = 4 GOTO 8080
GOTO 8090



'Non-Player Characters (NPCs) are the rest of the inhabitants of the game universe, from the people just strolling down to the
'street to the augmented assassin hunting his target. They are there to provide opportunities for interaction, whether that is to
'provide information or combat or just background colour.

'NPC MOTIVATIONS
'Much like PCs, NPCS also have motivations that lie behind everything that they do. In many cases,
'however, the motivations of NPCs are either obvious or unimportant. For example, general
'background characters, such as merchants or enemy soldiers, do not require a precise defnition
'of motivation. Motivation becomes necessary, however, with in?uential or potentially Important NPCs.
'Like PCs, their motivations are based on the standard deck of 'cards. If the Referee chooses to
'assign NPC motivations randomly, use the full deck and add both Joker cards. Otherwise,
'simply assign NPCs a motivation To determine NPC motivation, draw two cards from a standard
'deck of playing cards. The highest value card is the NPC's prime motivation, the other is his
'secondary motivation. The particular 'motive is determined by the suit of the card.
'Card values may be 'low (2, 3 or a 4), middle (5,6 or 7) or high (8,9 or 10). Aces and
'face cards have their own special meaning.

8050
'CLUBS
'Clubs Motivation NPCs add +1 to Str.
Suite$ = "The club suit indicates that violence plays a part in the NPC's makeup. ": STRENGTH = STRENGTH + 1
IF card = 1 THEN Suite$ = Suite$ + "The NPC is a natural military leader with an instinctive grasp of tactics and a good eye for terrain. The Referee should have him anticipate many situations and make allowances for them.": GOTO 8100
IF card < 5 THEN Suite$ = Suite$ + "The NPC is not frightened or intimidated by violence or its threat.": GOTO 8100
IF card < 8 THEN Suite$ = Suite$ + "The NPC is aggressive and accepts violence as a means of solving problems.": GOTO 8100
IF card < 11 THEN Suite$ = Suite$ + "The NPC loves a good fght. But this does not, however, indicate cruelty or brutality.": GOTO 8100
IF card = 11 THEN Suite$ = Suite$ + "The NPC is subjected to sudden, violent and uncontrollable rages."
IF card = 12 THEN Suite$ = Suite$ + "The NPC is stubborn, nearly impossible to persuade once he has made up his mind."
IF card = 13 THEN Suite$ = Suite$ + "The NPC is a sadistic brute who enjoys inflicting pain on others."

GOTO 8100

8060
'DIAMONDS
'Diamonds Motivation NPCs add +1 to Int.
Suite$ = "The diamonds suit indicate that the NPC has a concern for wealth. ": INTELLIGENCE = INTELLIGENCE + 1
IF card = 1 THEN Suite$ = Suite$ + "He is generous to a fault and gladly gives whatever he has to those in need.": GOTO 8100
IF card < 5 THEN Suite$ = Suite$ + "The NPC is cost-conscious and interested in making money.": GOTO 8100
IF card < 8 THEN Suite$ = Suite$ + "Making money is always the NPC's first consideration and he will always haggle over prices and wages.": GOTO 8100
IF card < 11 THEN Suite$ = Suite$ + "Easy to bribe and might betray his friends if the price is right.": GOTO 8100
IF card = 11 THEN Suite$ = Suite$ + "He is a total coward and will run from danger at every opportunity."
IF card = 12 THEN Suite$ = Suite$ + "The NPC is driven by lust for the opposite sex, either for a particular person or just in general."
IF card = 13 THEN Suite$ = Suite$ + "He is obsessed with money, believes everything has a price and will do anything if the price is right."

GOTO 8100

8070
'HEARTS
'Hearts Motivation NPCs add+1 to Soc.
Suite$ = "The hearts suit indicates that social interactions are very important to the NPC. ": SOCIAL = SOCIAL + 1
IF card = 1 THEN Suite$ = Suite$ + "He sees justice as the greatest virtue and the only important consideration in deciding on a course of action. He hates cheats, liars and crooks and will always assist any attempt to right an injustice.": GOTO 8100
IF card < 5 THEN Suite$ = Suite$ + "Amiable and cooperative.": GOTO 8100
IF card < 8 THEN Suite$ = Suite$ + "Indicates a willingness to take responsibility and a desire for a position of importance.": GOTO 8100
IF card < 11 THEN Suite$ = Suite$ + "Ambitious and manipulates the people around him for his own end.": GOTO 8100
IF card = 11 THEN Suite$ = Suite$ + "Has a strong commitment to fairness and reacts with anger to injustice and brutality."
IF card = 12 THEN Suite$ = Suite$ + "He will let nothing stand in the way of achieving any goal. He can appear to be considerate, generous, loyal or anything else which serves his purpose but beneath the exterior, he ruthlessly uses others for his own gain."
IF card = 13 THEN Suite$ = Suite$ + "He is scrupulously honest and his word of honour is his absolute bond. He has contempt for liars and anyone who breaks their word."

GOTO 8100

8080
'SPADES
'Spade Motivation NPCs add +1 to Int.
Suite$ = "The spades suit indicates that the NPC is motivated primarily by curiosity and a desire for knowledge. ": INTELLIGENCE = INTELLIGENCE + 1
IF card = 1 THEN Suite$ = Suite$ + "He is a charismatic natural teacher who draws others to him and inspires them.": GOTO 8100
IF card < 5 THEN Suite$ = Suite$ + "Someone who is mildly curious but will not take any risks to satisfy that curiosity": GOTO 8100
IF card < 8 THEN Suite$ = Suite$ + "Indicates a willingness to take responsibility and a desire for a position of importance.": GOTO 8100
IF card < 11 THEN Suite$ = Suite$ + "Indicates someone who is driven to fnd new knowledge and will not let things stand in their way.": GOTO 8100
IF card = 11 THEN Suite$ = Suite$ + "He is pompous and arrogant and clearly considers himself smarter than others."
IF card = 12 THEN Suite$ = Suite$ + "He is blinded by the pursuit of knowledge or enlightenment and is oblivious to the consequences of their actions."
IF card = 13 THEN Suite$ = Suite$ + "Rather than searching for the truth, he actively suppresses uncomfortable truths and leads others astray."

GOTO 8100
8090
'JOKERS
Suite$ = "Jokers indicate that the NPC's sanity is in question. "
IF card = 1 THEN Suite$ = Suite$ + "Minor (Replacement) Joker: The NPC is a harmless and entertaining eccentric."
IF card = 2 THEN Suite$ = Suite$ + "Major Joker: The NPC may actually appear to be completely normal or very eccentric but he is genuinely and hopelessly insane. The direction of his insanity is indicated by his other motivation card."

8100

card$ = subcard$(card) + " " + cardset$(suite) + ": " + Suite$
RETURN




9000 'QUICK NPCS
'It is often not necessary to generate a full, complex character
'for a given situation. In particular, faceless goons or a street
'crowd, do not all need detailed stats. In these cases, NPCs are
'assigned one of four levels of competence and designated as
'either combatants or non-combatants and given a primary motivation
'(one draw from the deck or one choice).

'Each NPC will have one skill from the list at the frst level
'and all other skills at the second level.
'Green NPCs have completely average Characteristics.
'More experienced NPCs can modify Characteristics, adding +1 to one
'Characteristic at Average and another +1 to any two Characteristics at Experienced
'and so on. The following below shows the cumulative Characteristic increase.



Gender$ = "M"
CLS
PRINT SPC(20); "G D W  R P G  NPC Generator"
PRINT
PRINT "       This will generate a stock NPC and directly write it to Disk."
xx = 22

LOCATE 7, xx + 5: PRINT "Either write SDEIES"
LOCATE 8, xx + 3: PRINT "or hit enter for random"

LOCATE 9, xx + 7: PRINT "<Y> to accept"

LOCATE 11, xx + 10

PRINT " SDEIES"
LOCATE 13, xx + 10
INPUT " ", character$
PRINT

556
IF character$ = "" THEN GOSUB 2000: LOCATE 13, xx + 11: PRINT character$: GOSUB 1000: IF a$ <> "Y" THEN character$ = "": GOTO 556

LOCATE 16, xx + 7
PRINT " Male / Female"


GOSUB 1000


'GOTO 9042 'CHARACTER$ = "63906B"

value$ = MID$(character$, 1, 1): GOSUB 50: STRENGTH = value
value$ = MID$(character$, 2, 1): GOSUB 50: DEXTERITY = value
value$ = MID$(character$, 3, 1): GOSUB 50: ENDURANCE = value
value$ = MID$(character$, 4, 1): GOSUB 50: INTELLIGENCE = value
value$ = MID$(character$, 5, 1): GOSUB 50: EDUCATION = value
value$ = MID$(character$, 6, 1): GOSUB 50: SOCIAL = value

IF CHOICE = 8 THEN GOSUB 20000


9042
LOCATE 19, 25
PRINT " Combat or Non-combat NPC ?"
GOSUB 1000: group$ = a$
LOCATE 21, 18
PRINT " (G)reen, (A)verage, E(X)pierienced, (E)lite"
GOSUB 1000

IF group$ = "N" GOTO 9005
GOTO 9045


'sk$(I), Skill(I)

'Non-combatants
'Experience Level Skills Levels Traits Characteristics

9005
IF a$ = "G" GOTO 9010
IF a$ = "A" GOTO 9020
IF a$ = "X" GOTO 9030
IF a$ = "E" GOTO 9040


9010 'Green
name$ = "Green, non-combatant NPC"
name$ = "Civilian, Green"
sk$(1) = "Drive (Wheel)": sk(1) = 0.1
sk$(2) = "Carouse": sk(2) = 0.1

'Drive, Carouse 0/0 Contact 777777
GOTO 9100



9020 'Average

name$ = "Average, non-combatant NPC"
name$ = "Civilian, Average"
sk$(1) = "Drive (Wheel)": sk(1) = 0.1
sk$(2) = "Carouse": sk(2) = 0.1
sk$(3) = "Trade": sk(3) = 1

INTELLIGENCE = INTELLIGENCE + 1


'Drive, Trade 'Carouse '1/0 Contact, 'Dependent '+1
GOTO 9100

9030 'Experienced
name$ = "Experienced, non-combatant NPC"
name$ = "Civilian, Experienced"
sk$(1) = "Drive (Wheel)": sk(1) = 1
sk$(2) = "Carouse": sk(2) = 1
sk$(3) = "Trade": sk(3) = 1
sk$(4) = "Admin": sk(4) = 2
INTELLIGENCE = INTELLIGENCE + 2
EDUCATION = EDUCATION + 1


'Drive, Admin, 'Carouse, Trade '2/1 Ally, Dependent '+2, +1
GOTO 9100





9040 'Elite
name$ = "Elite, non-combatant NPC"
name$ = "Civilian, Elite"
sk$(1) = "Drive (Wheel)": sk(1) = 2
sk$(2) = "Carouse": sk(2) = 2
sk$(3) = "Trade": sk(3) = 2
sk$(4) = "Investigate": sk(4) = 2
sk$(5) = "Admin": sk(5) = 3

INTELLIGENCE = INTELLIGENCE + 3
EDUCATION = EDUCATION + 2
SOCIAL = SOCIAL + 1

'Drive, Admin, 'Carouse, 'Trade, Investigate '3/2 Ally, Common Sense '+3, +2, '+1
GOTO 9100


9045
IF a$ = "G" GOTO 9050
IF a$ = "A" GOTO 9060
IF a$ = "X" GOTO 9070
IF a$ = "E" GOTO 9080


'Combatants 'Experience 'Level 'Skills Levels Traits Characteristics

9050 'Green
name$ = "Green, combatant NPC"
name$ = "Soldier, Green"


sk$(1) = "Gun Combat": sk(1) = 0.1
sk$(2) = "Melee": sk(2) = 0.1
sk$(3) = "Drive (Wheel)": sk(3) = 0.1

'Gun Combat, Melee, 'Drive '0/0 Contact 777777
GOTO 9100


9060 'Average
name$ = "Average, combatant NPC"
name$ = "Soldier, Average"

sk$(1) = "Gun Combat": sk(1) = 1
sk$(2) = "Melee": sk(2) = 0.1
sk$(1) = "Drive (Wheel)": sk(1) = 0.1
sk$(1) = "Recon": sk(1) = 0.1

DEXTERITY = DEXTERITY + 1


'Gun Combat, Melee, 'Drive, Recon 1/0
'Fearless +1
GOTO 9100


9070 'Experienced
name$ = "Experienced, combatant NPC"
name$ = "Soldier, Experienced"
sk$(1) = "Gun Combat": sk(1) = 2
sk$(2) = "Melee": sk(2) = 1
sk$(3) = "Drive (Wheel)": sk(3) = 1
sk$(4) = "Heavy Weapons": sk(4) = 1
DEXTERITY = DEXTERITY + 2
ENDURANCE = ENDURANCE + 1

'Gun Combat, Melee,'Drive,'Recon,'Heavy 'Weapons
'2/1 Tough/1 Coolness under Fire '+2, +1
GOTO 9100


9080 'Elite
name$ = "Elite, combatant NPC"
name$ = "Soldier, Elite"
sk$(1) = "Gun Combat": sk(1) = 3
sk$(2) = "Melee": sk(2) = 2
sk$(3) = "Drive (Wheel)": sk(3) = 2
sk$(4) = "Heavy Weapons": sk(4) = 2
sk$(5) = "Tactics": sk(5) = 2
DEXTERITY = DEXTERITY + 3
ENDURANCE = ENDURANCE + 2
STRENGTH = STRENGTH + 1
'Gun Combat, Melee, 'Drive, 'Recon, 'Heavy Weapons, 'Tactics '3/2
'Tough/2, Coolness under Fire +3, +2, +1
GOTO 9100

9100 xx = 5: IF Tskill > xx THEN xx = Tskill
FOR I = 1 TO xx
    IF sk(I) < 1 THEN sk(I) = .2
    'PRINT sk$(I); sk(I) * -1
    IF sk$(I) = "Jack-of-all-Trades" OR sk$(I) = "JOT" OR sk$(I) = "Jack-o-T" OR sk$(I) = "Jack of all trades" THEN sk$(I) = "Jack-of-all-Trades"
    'PRINT sk$(I); sk(I)
    IF sk$(I) = "Jack-of-all-Trades" THEN JOT = -3 + sk(I)
    IF JOT > 3 THEN JOT = 3
    sk$(I) = UCASE$(sk$(I))

NEXT
CLOSE #1
FOR I = 1 TO SKILL
    FOR Z = 1 TO xx
        IF sk$(Z) = SKILL$(I) THEN skill(I) = sk(Z)
    NEXT
NEXT

character$ = ""
value = STRENGTH: GOSUB 60: character$ = character$ + value$
value = DEXTERITY: GOSUB 60: character$ = character$ + value$
value = ENDURANCE: GOSUB 60: character$ = character$ + value$
value = INTELLIGENCE: GOSUB 60: character$ = character$ + value$
value = EDUCATION: GOSUB 60: character$ = character$ + value$
value = SOCIAL: GOSUB 60: character$ = character$ + value$

'GOSUB 1000

GOTO 100




'When noting down Quick NPCs, all that needs to be noted are any exceptional skills or Characteristics.

'So, an Elite Combatant would be noted as:
'Elite Combatant, Gun Combat, Dex +3, Str +2, Int +1, Clubs 5 (+1 Str)

'This translates to

'Str 10 End 7 Dex 10 Int 8 Edu 7 Soc 7,
'Gun Combat/3, Melee/2, Drive/2, Recon/2, Heavy Weapons/2, 'Tactics/2 'Tough/2, Coolness Under Fire
'Then these Quick NPCs just need basic equipment and armour and they are quickly ready to go.



























99 ' ANIMAL
'Terrain Subtype DM Size DM 1 2 3 4 5 6
DATA "Clear               ",+3,-0,"W  W  W  W  W+2F-6"
DATA "Plain or Prairie    ",+4,-0,"W  W  W  W+2W+4F-6"
DATA "Desert (hot or cold)",+3,-3,"W  W  W  W  F-4F-6"
DATA "Hills, Foothills    ",-0,-0,"W  W  W  W+2F-4F-6"
DATA "Mountain, Alpine    ",-0,-0,"W  W  W  F-2F-4F-6"
DATA "Forest              ",-4,-4,"W  W  W  W  F-4F-6"
DATA "Woods               ",-2,-1,"W  W  W  W  W  F-6"
DATA "Jungle              ",-4,-3,"W  W  W  W  W+2F-6"
DATA "Rainforest          ",-2,-2,"W  W  W  W+2W+4F-6"
DATA "Rough, Broken       ",-3,-3,"W  W  W  W+2F-4F-6"
DATA "Swamp, Marsh        ",-2,+4,"S-6A+2W  W  F-4F-6"
DATA "Beach, Shore        ",+3,+2,"S+1A+2W  W  F-4F-6"
DATA "River, Riverbank    ",+1,+1,"S-4A  W  W  W  F-6"
DATA "Ocean shallows      ",+4,+1,"S+4S+2S  S  F-4F-6"
DATA "Open ocean          ",+4,-4,"S+6S+4S+2S  F-4F-6"
DATA "Deep ocean          ",+4,+2,"S+8S+6S+4S+2S  S-2"

DATA "Marsh, Wetland      ",-0,-1,"S-6A+2W  W  F-4F-6"
DATA "Sea Cavern          ",-2,0,"S+8S+6S+4S+2S  S-2"
DATA "Sargasso, Seaweed   ",-4,-2,"S+4S+2S  S  F-4F-6"
DATA "Ruins, Old City     ",-3,0,"W  W  W  W  W+2F-6"
DATA "Cavern              ",-4,+1,"W  W  W  W  W+2F-6"
DATA "Crevasse, Abyss     ",-1,-3,"W  W  W  W  W+2F-6"
DATA "Crater Hollow       ",-0,-1,"W  W  W  W  W+2F-6"

PRINT SPC(18); "G D W  R P G  Animal Generator"

Animal = 1

IF CHOICE = 7 THEN GOTO 16001

PRINT
PRINT SPC(16); "World Size, (S)mall, (M)edium, (L)arge": PRINT
GOSUB 1000
World$ = "Medium sized World": WSM = 0

IF a$ = "S" THEN WSM = 1: World$ = "Small World"
IF a$ = "L" THEN WSM = -1: World$ = "Large World"

RESTORE 99
FOR I = 1 TO SZ: READ terrain$(I), subtype(I), size(I), move$(I): NEXT
FOR I = 65 TO 90
    FOR J = 1 TO SZ
        IF LEFT$(terrain$(J), 1) = CHR$(I) THEN Z = Z + 1: typ(Z) = J
    NEXT
NEXT
'END


FOR I = 1 TO SZ: PRINT USING "##. "; I;: PRINT terrain$(typ(I)),:
    IF I / 3 = INT(I / 3) THEN PRINT

NEXT: PRINT
PRINT
INPUT " ", terrain: IF terrain = 0 OR terrain > SZ THEN terrain = INT(RND * SZ) + 1
terrain = typ(terrain)

terrain$ = terrain$(terrain)
2 IF RIGHT$(terrain$, 1) = " " THEN terrain$ = LEFT$(terrain$, (LEN(terrain$) - 1)): GOTO 2


subtypeDM = subtype(terrain)
sizeDM = size(terrain)
3
MV = INT(RND * 6) + 1: move$ = MID$(move$(terrain), (MV - 1) * 3 + 1, 3)
IF MV = 1 THEN move$ = LEFT$(move$(terrain), 3)
movetype$ = LEFT$(move$, 1)
AdSizeDM = VAL(RIGHT$(move$, 2))


mmt$ = movetype$: mmx$ = ""


16001 IF CHOICE <> 7 GOTO 16003
'INPUT MONSTER MOVEMENT

PRINT
sp = sp - 3

PRINT
PRINT SPC(sp); " (W)alking, (S)wimming or (F)lying"
GOSUB 1000: mmt$ = a$
16003

IF mmt$ = "W" THEN mmx$ = "walking":
IF mmt$ = "S" THEN mmx$ = "swimming"
IF mmt$ = "F" THEN mmx$ = "flying": sizeDM = 0
IF mmt$ = "A" THEN mmx$ = "amphibious"
IF mmx$ = "" GOTO 16001
IF CHOICE = 7 GOTO 18

IF mmx$ = "" GOTO 3
PRINT " "; terrain$; ", "; mmx$;
PRINT " 1 Herbivore, 2 Omnivore, 3 Carnivore, 4 Scavenger"
GOSUB 1000: typ = VAL(a$)
IF mmt$ = "W" THEN mmx$ = "":


IF typ = 0 OR typ > 4 THEN typ = INT(RND * 4) + 1

IF typ = 1 THEN RESTORE 10: typ$ = "Herbivore"
IF typ = 2 THEN RESTORE 12: typ$ = "Omnivore"
IF typ = 3 THEN RESTORE 14: typ$ = "Carnivore"
IF typ = 4 THEN RESTORE 16: typ$ = "Scavenger"

'Table: Subtype by Animal Type
'2D6 Herbivore Omnivore Carnivore Scavenger

subtype = INT(RND * 6) + INT(RND * 6) + 2 + subtypeDM
IF subtype < 1 THEN subtype = 1
IF subtype > 13 THEN subtype = 13

FOR I = 1 TO subtype: READ subtype$: NEXT
PRINT
PRINT " "; terrain$; " "; subtype$; ", Size DM"; sizeDM + AdSizeDM
'GOSUB 1000

10
'Herbivore
DATA " 1 Filter"
DATA " 2 Filter"
DATA " 3 Intermitent"
DATA " 4 Intermitent"
DATA " 5 Intermitent"
DATA " 6 Intermitent"
DATA " 7 Grazer"
DATA " 8 Grazer"
DATA " 9 Grazer"
DATA "10 Grazer"
DATA "11 Grazer"
DATA "12 Grazer"
DATA "13 Grazer"

12
'Omnivore
DATA " 1 Gatherer"
DATA " 2 Eater"
DATA " 3 Gatherer"
DATA " 4 Eater"
DATA " 5 Gatherer"
DATA " 6 Hunter"
DATA " 7 Hunter"
DATA " 8 Hunter"
DATA " 9 Gatherer"
DATA "10 Eater"
DATA "11 Hunter"
DATA "12 Gatherer"
DATA "13 Gatherer"

14
'Carnivore
DATA " 1 Pouncer"
DATA " 2 Siren"
DATA " 3 Pouncer"
DATA " 4 Killer"
DATA " 5 Trapper"
DATA " 6 Pouncer"
DATA " 7 Chaser"
DATA " 8 Chaser"
DATA " 9 Chaser"
DATA "10 Killer"
DATA "11 Chaser"
DATA "12 Siren"
DATA "13 Chaser"

16
'Scavenger
DATA " 1 Carrion-Eater"
DATA " 2 Reducer"
DATA " 3 Hijacker"
DATA " 4 Carrion-Eater"
DATA " 5 Intimidator"
DATA " 6 Reducer"
DATA " 7 Carrion-Eater"
DATA " 8 Reducer"
DATA " 9 Hijacker"
DATA "10 Intimidator"
DATA "11 Reducer"
DATA "12 Hijacker"
DATA "13 Intimidator"


subtype$ = RIGHT$(subtype$, LEN(subtype$) - 3)

SD = 1: SM = -2: MinS = 2
18 'INPUT MONSTER CLASS
IF CHOICE <> 7 GOTO 181
PRINT: typ = 3
PRINT SPC(sp); " (C)haser, (K)iller, (P)ouncer"
GOSUB 1000
IF a$ = "C" THEN subtype$ = "Chaser": typ$ = "Carnivore"
IF a$ = "K" THEN subtype$ = "Killer": typ$ = "Carnivore"
IF a$ = "P" THEN subtype$ = "Pouncer": typ$ = "Carnivore"
IF typ$ = "" GOTO 18
PRINT
PRINT SPC(sp); " (S)mall, (M)edium, (L)arge, (X)tra Large, (G)odzilla"
GOSUB 1000
IF a$ = "S" THEN sizeDM = -2
IF a$ = "M" THEN sizeDM = 0
IF a$ = "L" THEN sizeDM = 2
IF a$ = "X" THEN sizeDM = 6
IF a$ = "G" THEN sizeDM = 20


181


IF subtype$ = "Carrion-Eater" THEN animal$ = "It will wait for all other threats to disperse before beginning to feed."
IF subtype$ = "Chaser" THEN animal$ = "It kills its prey by attacking and exhausting it after a chase. If the chasers outnumber the characters, they attack."
IF subtype$ = "Eater" THEN animal$ = "It will eat anything it encounters, including characters."
IF subtype$ = "Filter" THEN animal$ = "It passes its environment through its body. Unlike grazers, which move to food, filters move a flow of matter through themselves and filter out the food."
IF subtype$ = "Gatherer" THEN animal$ = "It will try to collect and store plants as food."
IF subtype$ = "Grazer" THEN animal$ = "It moves from food source to food source, often in large packs. Its primary form of defense tends to be fleeing danger."
IF subtype$ = "Hijacker" THEN animal$ = "It will try to steal the kills of others through brute force or weight of numbers."
IF subtype$ = "Hunter" THEN animal$ = "It is an opportunistic predator that stalks easy prey. If it is bigger than at least one character, then it attacks on a 6+. Otherwise, it attacks on a 10+."
IF subtype$ = "Intermitent" THEN animal$ = "A plant eater that will not devote its entire time to searching for food. Can be curious."
IF subtype$ = "Intimidator" THEN animal$ = "It tries to establish its claim to food by frightening or intmidating other creatures."
IF subtype$ = "Killer" THEN animal$ = "It is possessed by a raw killing instinct, it will attack in a frenzied manner."
IF subtype$ = "Pouncer" THEN animal$ = "It will try to stalk and ambush its prey. If it has surprise, it attacks. If it is surprised, it flees."
IF subtype$ = "Reducer" THEN animal$ = "It will act constantly on all available food, devouring even the remains left by other scavengers."
IF subtype$ = "Siren" THEN animal$ = "It creates a lure to attract prey. Usually, this lure will be specifc to the species the siren preys on, but some rare lures are universal. If the siren has surprise, it attacks."
IF subtype$ = "Trapper" THEN animal$ = "It will try to entrap its prey. Generally, any creature surprised by a trapper is caught in its trap. If the trapper has surprise, it attacks."

IF subtype$ = "Carrion-Eater" THEN InstDM = 2: SM = -3: MinS = 1: ATTACK = 11: Fleeminus = 7
IF subtype$ = "Chaser" THEN Athletics = 1: DexDM = 4: InstDM = 2: PackDM = 2: SM = -2: MinS = 2: ATTACK = 2: Fleeminus = 5
IF subtype$ = "Eater" THEN EndDM = 4: PackDM = 2: SM = -3: MinS = 1: ATTACK = 5: Fleeminus = 4
IF subtype$ = "Filter" THEN EndDM = 4: SM = -5: MinS = 0: ATTACK = 10: Fleeminus = 5
IF subtype$ = "Gatherer" THEN Recon = 1: PackDM = 2: SM = -3: MinS = 1: ATTACK = 9: Fleeminus = 7
IF subtype$ = "Grazer" THEN InstDM = 2: PackDM = 4: SM = -2: MinS = 2: ATTACK = 8: Fleeminus = 6
IF subtype$ = "Hijacker" THEN StrDM = 2: PackDM = 2: SM = -4: MinS = 1: ATTACK = 7: Fleeminus = 6
IF subtype$ = "Hunter" THEN Survival = 1: InstDM = 2: SM = -4: MinS = 1: ATTACK = 6: Fleeminus = 5
IF subtype$ = "Intermitent" THEN PackDM = 4: SM = -4: MinS = 1: ATTACK = 10: Fleeminus = 4
IF subtype$ = "Intimidator" THEN SM = -4: MinS = 1: ATTACK = 11: Fleeminus = 7
IF subtype$ = "Killer" THEN combat = 4: InstDM = 4: PackDM = -2: SM = -3: MinS = 1: ATTACK = 8: Fleeminus = 7
IF subtype$ = "Pouncer" THEN Recon = 1: Athletics = 1: DexDM = 4: InstDM = 4: SM = -4: MinS = 1: ATTACK = 2: Fleeminus = 12
IF subtype$ = "Reducer" THEN PackDM = 4: SM = -4: MinS = 1: ATTACK = 10: Fleeminus = 7
IF subtype$ = "Siren" THEN PackDM = -4: SM = -4: MinS = 0: ATTACK = 2: Fleeminus = 4
IF subtype$ = "Trapper" THEN PackDM = -2: SM = -5: MinS = 0: ATTACK = 2: Fleeminus = 5

IF subtype$ = "Killer" AND RND < .5 THEN StrDM = 4 ELSE DexDM = 4

IF mmt$ = "F" THEN SM = SM + 2: MinS = 2
IF mmt$ = "S" THEN SM = SM - 2: MinS = .5

IF MinS = 1 THEN MinS = .5

IF CHOICE <> 7 GOTO 19
PRINT
PRINT SPC(sp); " (S)low, (M)edium, (F)ast, (V)ery fast, (X)tremly fast"
GOSUB 1000
IF a$ = "S" THEN SM = SM - 2
IF a$ = "M" THEN SM = SM
IF a$ = "F" THEN SM = SM + 2
IF a$ = "V" THEN SM = SM + 4
IF a$ = "X" THEN SM = SM + 6






19
speedmult = (RND * 6) + 1 + SM: IF speedmult < MinS THEN speedmult = MinS
Speed = INT(speedmult * 6)
speed$ = "A"
IF Speed < 6 THEN speed$ = "A slow"
IF Speed > 10 THEN speed$ = "A fast"
IF Speed > 15 THEN speed$ = "A very fast"
IF Speed > 20 THEN speed$ = "An extremely fast"




SIZE = INT(RND * 6) + INT(RND * 6) + 2 + sizeDM + AdSizeDM + WSM

IF mmt$ = "F" AND SIZE > 7 THEN SIZE = 7


IF SIZE < 1 THEN SIZE = 1
IF SIZE > 20 THEN SIZE = 20
IF SIZE = 1 THEN Weight = 1: size$ = "Weasel": STRENGTH = 1: DEXTERITY = INT(RND * 6) + 1: ENDURANCE = 1
IF SIZE = 2 THEN Weight = 3: size$ = "Fox": STRENGTH = 2: DEXTERITY = INT(RND * 6) + 1: ENDURANCE = 2
IF SIZE = 3 THEN Weight = 6: size$ = "Racoon": STRENGTH = INT(RND * 6) + 1: FOR I = 1 TO 2: DEXTERITY = DEXTERITY + INT(RND * 6) + 1: NEXT: ENDURANCE = INT(RND * 6) + 1
IF SIZE = 4 THEN Weight = 12: size$ = "Badger": STRENGTH = INT(RND * 6) + 1: FOR I = 1 TO 2: DEXTERITY = DEXTERITY + INT(RND * 6) + 1: NEXT: ENDURANCE = INT(RND * 6) + 1
IF SIZE = 5 THEN Weight = 25: size$ = "Beaver": FOR I = 1 TO 2: STRENGTH = STRENGTH + INT(RND * 6) + 1: NEXT: FOR I = 1 TO 3: DEXTERITY = DEXTERITY + INT(RND * 6) + 1: NEXT: FOR I = 1 TO 2: ENDURANCE = ENDURANCE + INT(RND * 6) + 1: NEXT
IF SIZE = 6 THEN Weight = 50: size$ = "Leopard": FOR I = 1 TO 2: STRENGTH = STRENGTH + INT(RND * 6) + 1: NEXT: FOR I = 1 TO 4: DEXTERITY = DEXTERITY + INT(RND * 6) + 1: NEXT: FOR I = 1 TO 2: ENDURANCE = ENDURANCE + INT(RND * 6) + 1: NEXT
IF SIZE = 7 THEN Weight = 100: size$ = "Black bear": FOR I = 1 TO 3: STRENGTH = STRENGTH + INT(RND * 6) + 1: NEXT: FOR I = 1 TO 3: DEXTERITY = DEXTERITY + INT(RND * 6) + 1: NEXT: FOR I = 1 TO 3: ENDURANCE = ENDURANCE + INT(RND * 6) + 1: NEXT
IF SIZE = 8 THEN Weight = 200: size$ = "Tiger": FOR I = 1 TO 2: STRENGTH = STRENGTH + INT(RND * 6) + 1: NEXT: FOR I = 1 TO 3: DEXTERITY = DEXTERITY + INT(RND * 6) + 1: NEXT: FOR I = 1 TO 3: ENDURANCE = ENDURANCE + INT(RND * 6) + 1: NEXT
IF SIZE = 9 THEN Weight = 400: size$ = "Polar bear": FOR I = 1 TO 4: STRENGTH = STRENGTH + INT(RND * 6) + 1: NEXT: FOR I = 1 TO 4: DEXTERITY = DEXTERITY + INT(RND * 6) + 1: NEXT: FOR I = 1 TO 4: ENDURANCE = ENDURANCE + INT(RND * 6) + 1: NEXT
IF SIZE = 10 THEN Weight = 800: size$ = "Buffalo": FOR I = 1 TO 4: STRENGTH = STRENGTH + INT(RND * 6) + 1: NEXT: FOR I = 1 TO 2: DEXTERITY = DEXTERITY + INT(RND * 6) + 1: NEXT: FOR I = 1 TO 4: ENDURANCE = ENDURANCE + INT(RND * 6) + 1: NEXT
IF SIZE = 11 THEN Weight = 1600: size$ = "Rhino": FOR I = 1 TO 5: STRENGTH = STRENGTH + INT(RND * 6) + 1: NEXT: FOR I = 1 TO 2: DEXTERITY = DEXTERITY + INT(RND * 6) + 1: NEXT: FOR I = 1 TO 5: ENDURANCE = ENDURANCE + INT(RND * 6) + 1: NEXT
IF SIZE = 12 THEN Weight = 3200: size$ = "Elephant": FOR I = 1 TO 5: STRENGTH = STRENGTH + INT(RND * 6) + 1: NEXT: FOR I = 1 TO 1: DEXTERITY = DEXTERITY + INT(RND * 6) + 1: NEXT: FOR I = 1 TO 5: ENDURANCE = ENDURANCE + INT(RND * 6) + 1: NEXT
IF SIZE = 13 THEN Weight = 5000: size$ = "Stegosaurus": FOR I = 1 TO 6: STRENGTH = STRENGTH + INT(RND * 6) + 1: NEXT: FOR I = 1 TO 1: DEXTERITY = DEXTERITY + INT(RND * 6) + 1: NEXT: FOR I = 1 TO 6: ENDURANCE = ENDURANCE + INT(RND * 6) + 1: NEXT
IF SIZE = 14 THEN Weight = 10000: size$ = "Tyrannosaurus Rex": FOR I = 1 TO 6: STRENGTH = STRENGTH + INT(RND * 6) + 1: NEXT: FOR I = 1 TO 1: DEXTERITY = DEXTERITY + INT(RND * 6) + 1: NEXT: FOR I = 1 TO 6: ENDURANCE = ENDURANCE + INT(RND * 6) + 1: NEXT
IF SIZE = 15 THEN Weight = 15000: size$ = "Triceratops": FOR I = 1 TO 7: STRENGTH = STRENGTH + INT(RND * 6) + 1: NEXT: FOR I = 1 TO 1: DEXTERITY = DEXTERITY + INT(RND * 6) + 1: NEXT: FOR I = 1 TO 7: ENDURANCE = ENDURANCE + INT(RND * 6) + 1: NEXT
IF SIZE = 16 THEN Weight = 20000: size$ = "Spinosaurus": FOR I = 1 TO 7: STRENGTH = STRENGTH + INT(RND * 6) + 1: NEXT: FOR I = 1 TO 1: DEXTERITY = DEXTERITY + INT(RND * 6) + 1: NEXT: FOR I = 1 TO 7: ENDURANCE = ENDURANCE + INT(RND * 6) + 1: NEXT
IF SIZE = 17 THEN Weight = 25000: size$ = "Megalodon": FOR I = 1 TO 8: STRENGTH = STRENGTH + INT(RND * 6) + 1: NEXT: FOR I = 1 TO 1: DEXTERITY = DEXTERITY + INT(RND * 6) + 1: NEXT: FOR I = 1 TO 8: ENDURANCE = ENDURANCE + INT(RND * 6) + 1: NEXT
IF SIZE = 18 THEN Weight = 30000: size$ = "small Apatosurus": FOR I = 1 TO 8: STRENGTH = STRENGTH + INT(RND * 6) + 1: NEXT: FOR I = 1 TO 1: DEXTERITY = DEXTERITY + INT(RND * 6) + 1: NEXT: FOR I = 1 TO 8: ENDURANCE = ENDURANCE + INT(RND * 6) + 1: NEXT
IF SIZE = 19 THEN Weight = 35000: size$ = "Humpback Whale": FOR I = 1 TO 9: STRENGTH = STRENGTH + INT(RND * 6) + 1: NEXT: FOR I = 1 TO 1: DEXTERITY = DEXTERITY + INT(RND * 6) + 1: NEXT: FOR I = 1 TO 9: ENDURANCE = ENDURANCE + INT(RND * 6) + 1: NEXT
IF SIZE = 20 THEN Weight = 40000: size$ = "Sperm Whale": FOR I = 1 TO 9: STRENGTH = STRENGTH + INT(RND * 6) + 1: NEXT: FOR I = 1 TO 1: DEXTERITY = DEXTERITY + INT(RND * 6) + 1: NEXT: FOR I = 1 TO 9: ENDURANCE = ENDURANCE + INT(RND * 6) + 1: NEXT


20 IF mmt$ <> "F" THEN GOTO 25
IF SIZE = 1 THEN Weight = .5: size$ = "Falcon":
IF SIZE = 2 THEN Weight = 1: size$ = "Raven":
IF SIZE = 3 THEN Weight = 6: size$ = "Eagle":
IF SIZE = 4 THEN Weight = 12: size$ = "Vulture":
IF SIZE = 5 THEN Weight = 25: size$ = "small Pteranodon":
IF SIZE = 6 THEN Weight = 50: size$ = "large Pteranodon"
IF SIZE > 6 THEN Weight = 100: size$ = "Quetzalcoatlus"
25
IF mmt$ <> "S" THEN GOTO 29
IF SIZE = 1 THEN Weight = 1: size$ = "Trout"
IF SIZE = 2 THEN Weight = 3: size$ = "large Trout"
IF SIZE = 3 THEN Weight = 6: size$ = "small Salmon"
IF SIZE = 4 THEN Weight = 12: size$ = "Salmon"
IF SIZE = 5 THEN Weight = 25: size$ = "Pike"
IF SIZE = 6 THEN Weight = 50: size$ = "Cod"
IF SIZE = 7 THEN Weight = 100: size$ = "Bull shark"
IF SIZE = 8 THEN Weight = 200: size$ = "Dolphin"
IF SIZE = 9 THEN Weight = 400: size$ = "Swordfish"
IF SIZE = 10 THEN Weight = 800: size$ = "Tiger shark"
IF SIZE = 11 THEN Weight = 1600: size$ = "Manta Rey"
IF SIZE = 12 THEN Weight = 3200: size$ = "Great white shark"
IF SIZE = 13 THEN Weight = 5000: size$ = "Minke whale"
IF SIZE = 14 THEN Weight = 10000: size$ = "Orca"
IF SIZE = 15 THEN Weight = 15000: size$ = "Beaked whale"
IF SIZE = 16 THEN Weight = 20000: size$ = "Whale shark":
IF SIZE = 17 THEN Weight = 25000: size$ = "Megalodon":
IF SIZE = 18 THEN Weight = 30000: size$ = "Gray whale"
IF SIZE = 19 THEN Weight = 35000: size$ = "Humpback Whale":
IF SIZE = 20 THEN Weight = 40000: size$ = "Sperm Whale":
29

Weight = INT(Weight + ((Weight / 20) * (RND - .5))): IF Weight < 1 THEN Weight = 1

STRENGTH = STRENGTH + StrDM
DEXTERITY = DEXTERITY + DexDM
ENDURANCE = ENDURANCE + EndDM

INSTINCT = INT(RND * 6) + INT(RND * 6) + 2 + InstDM

character$ = ""
value = STRENGTH: GOSUB 60: character$ = value$
value = DEXTERITY: GOSUB 60: character$ = character$ + value$
value = ENDURANCE: GOSUB 60: character$ = character$ + value$
INTELLIGENCE = 0: IF RND > .5 THEN INTELLIGENCE = 1
value = INTELLIGENCE: GOSUB 60: character$ = character$ + value$
value = INSTINCT: GOSUB 60: character$ = character$ + value$
PACK = INT(RND * 6) + INT(RND * 6) + 2 + PackDM: IF PACK < 0 THEN PACK = 0
IF CHOICE = 7 THEN PACK = 1

value = PACK: GOSUB 60: character$ = character$ + value$
IF PACK = 0 THEN number = 1: GOTO 30
IF PACK < 3 THEN number = INT(RND * 3) + 1: GOTO 30
IF PACK < 6 THEN number = INT(RND * 6) + 1: GOTO 30
IF PACK < 9 THEN FOR I = 1 TO 2: number = number + INT(RND * 6) + 1: NEXT: GOTO 30
IF PACK < 12 THEN FOR I = 1 TO 3: number = number + INT(RND * 6) + 1: NEXT: GOTO 30
IF PACK < 15 THEN FOR I = 1 TO 4: number = number + INT(RND * 6) + 1: NEXT: GOTO 30
FOR I = 1 TO 5: number = number + INT(RND * 6) + 1: NEXT: GOTO 30

30
Armor = 0
'Table: Animal Armor
'2D6 Armor
wurf = INT(RND * 6) + INT(RND * 6) - 5 + SIZE
IF typ = 1 THEN wurf = wurf + 4
IF typ = 4 THEN wurf = wurf + 2
IF typ = 3 THEN wurf = wurf - 2
IF mmt$ = "F" THEN wurf = wurf - 2


IF wurf < 4 THEN Armor = 0: armor$ = " covered with skin ": GOTO 40
IF wurf < 6 THEN Armor = 1: armor$ = " covered with a pelt ": GOTO 40
IF wurf < 8 THEN Armor = 2: armor$ = " covered with a thick pelt ": GOTO 40
IF wurf < 10 THEN Armor = 3: armor$ = " covered with thick hide ": GOTO 40
IF wurf < 12 THEN Armor = 4: armor$ = " covered with tough hide ": GOTO 40
IF wurf < 14 THEN Armor = 5: armor$ = " covered with tough hide and bone plates ": GOTO 40
IF wurf < 16 THEN Armor = 6: armor$ = " armored with bone plates ": GOTO 40
Armor = 7: armor$ = " armored with thick bone plates "
'fur, scales , hide, shell
40
IF mmt$ = "F" AND Armor < 2 THEN armor$ = " covered with feathers "
IF mmt$ = "F" AND Armor >= 2 THEN armor$ = " covered with a thick skin "

IF mmt$ = "S" AND Armor < 3 THEN armor$ = " covered with scales "
IF mmt$ = "S" AND Armor >= 3 THEN armor$ = " covered with a thick skin "
IF mmt$ = "S" AND Armor > 5 THEN armor$ = " covered with armored scales "


'Table: Animal Weapons
Weapons = INT(RND * 6) + INT(RND * 6) + 2
IF typ = 1 THEN Weapons = Weapons - 6
IF typ = 2 THEN Weapons = Weapons + 4
IF typ = 3 THEN Weapons = Weapons + 8


DAMD = 0: dama = 0
IF Weapons < 2 THEN Weapon$ = "Hooves": range$ = "Extended": IF mmt$ = "S" THEN Weapon$ = "Teeth"
IF Weapons = 2 THEN Weapon$ = "Hooves and Horns": range$ = "Extended": IF mmt$ = "S" THEN Weapon$ = "Teeth"
IF Weapons = 3 THEN Weapon$ = "Horns": range$ = "Extended": IF mmt$ = "S" THEN Weapon$ = "Teeth"
IF Weapons = 4 THEN Weapon$ = "Hooves and Teeth": range$ = "Both": IF mmt$ = "S" THEN Weapon$ = "Teeth"
IF Weapons = 5 THEN Weapon$ = "Horns and Teeth": range$ = "Both": IF mmt$ = "S" THEN Weapon$ = "Teeth"
IF Weapons = 6 THEN Weapon$ = "Thrasher": range$ = "Close"
IF Weapons = 7 THEN Weapon$ = "Claws": range$ = "Extended"
IF Weapons = 8 THEN Weapon$ = "Teeth": range$ = "Close"
IF Weapons = 9 THEN Weapon$ = "Claws and Teeth": range$ = "Both"
IF Weapons = 10 THEN Weapon$ = "Claws": DAMD = 1: range$ = "Extended"
IF Weapons = 11 THEN Weapon$ = "Stinger": range$ = "Close"
IF Weapons = 12 THEN Weapon$ = "Teeth": DAMD = 1: range$ = "Close"
IF Weapons = 13 THEN Weapon$ = "Claws and Teeth": DAMD = 1: range$ = "Both"
IF Weapons = 14 THEN Weapon$ = "Claws and Stinger": DAMD = 1: range$ = "Both"
IF Weapons = 15 THEN Weapon$ = "sharp Claws": DAMD = 2: range$ = "Extended"
IF Weapons = 16 THEN Weapon$ = "Saberteeth": DAMD = 2: range$ = "Close"
IF Weapons = 17 THEN Weapon$ = "sharp Claws and Saberteeth": DAMD = 2: range$ = "Both"
IF Weapons = 18 THEN Weapon$ = "sharp Claws, Saberteeth and Stinger": DAMD = 2: range$ = "Both"
IF Weapons = 19 THEN Weapon$ = "Razorclaws, Saberteeth and Stinger": DAMD = 3: range$ = "Both"
IF Weapons > 19 THEN Weapon$ = "Shooter": range$ = "Throw"

IF typ = 4 AND LEFT$(Weapon$, 5) <> "Teeth" AND RIGHT$(Weapon$, 4) <> "eeth" THEN Weapon$ = "Teeth and " + Weapon$

damage = INT(STRENGTH / 10) + DAMD
dama = INT((STRENGTH / 10 - INT(STRENGTH / 10)) * 3.5)
IF damage = 0 THEN damage = 1: dama = (3.5 - dama) * -1


IF range$ = "Close" THEN PE = 0: CL = -2: SH = -99: ME = -99: LO = -99: VL = -99: DI = -99
IF range$ = "Extended" THEN PE = -2: CL = 0: SH = -99: ME = -99: LO = -99: VL = -99: DI = -99
IF range$ = "Throw" THEN PE = -99: CL = 0: SH = -2: ME = -2: LO = -99: VL = -99: DI = -99
IF range$ = "Both" THEN PE = 0: CL = 0: SH = -99: ME = -99: LO = -99: VL = -99: DI = -99








Skills = INT(INSTINCT * RND): CSKILL = 1
59
IF Skills > 0 AND RND > .5 THEN Athletics = Athletics + 1: Skills = Skills - 1
IF Skills > 0 AND RND > .5 THEN Recon = Recon + 1: Skills = Skills - 1
IF Skills > 0 AND RND > .5 THEN Survival = Survival + 1: Skills = Skills - 1
IF Skills > 0 AND RND > .5 THEN combat = combat + 1: Skills = Skills - 1
IF Skills > 0 GOTO 59

SkillZ = 0
sk$(1) = "Dexterity": sk(1) = Athletics: SkillZ = 1
IF Recon > 0 THEN SkillZ = SkillZ + 1: sk(SkillZ) = Recon: sk$(SkillZ) = "Recon"
IF Survival > 0 THEN SkillZ = SkillZ + 1: sk(SkillZ) = Survival: sk$(SkillZ) = "Survival"
IF combat > 0 THEN SkillZ = SkillZ + 1: sk(SkillZ) = combat: sk$(SkillZ) = "Melee (natural)"

FOR Z = 1 TO SkillZ: sk$(Z) = UCASE$(sk$(Z))
    PRINT " "; sk$(Z); sk(Z)
    IF sk(Z) = 0 THEN sk(Z) = .2
NEXT

FOR I = 1 TO SKILL
    FOR Z = 1 TO SkillZ
        IF sk$(Z) = SKILL$(I) THEN skill(I) = sk(Z): PRINT sk$(Z); skill(I)
    NEXT
NEXT




CLS
text$ = " " + World$ + ", " + terrain$ + "," + STR$(number) + " x " + mmx$ + " " + subtype$
IF CHOICE = 7 THEN text$ = STR$(number) + " x " + mmx$ + " " + subtype$

PRINT text$
PRINT
text$ = speed$ + " " + typ$ + ", the size of a " + size$ + "," + armor$ + "and armed with " + Weapon$ + ". " + animal$: GOSUB 19999
PRINT
PRINT " "; character$; ","; Weight; "kg, Speed:"; Speed; INT(Speed / 6 * 3.6 * 10) / 10; "to"; INT(Speed / 6 * 3.6 * 5.6); "km/h."
PRINT
PRINT USING " Instinct## Attack##+/Flight##"; INSTINCT; ATTACK; Fleeminus;: PRINT "-"
PRINT: PRINT USING " Athletics+# "; -Athletics;
IF Recon > 0 THEN PRINT USING ", Recon+# "; -Recon;
IF Survival > 0 THEN PRINT USING ", Survival+# "; -Survival;
PRINT: PRINT: GOTO 90
PRINT
PRINT " "; Weapon$; SPC(17 - LEN(Weapon$));
PRINT "³  1.5 m ³    3 m ³   12 m ³   50 m ³"
PRINT "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄ´"
PRINT USING "##D6"; damage;
IF dama <> 0 THEN PRINT USING "+#"; dama; ELSE PRINT "  ";
PRINT SPC(12); "³ ";
value = DEXTERITY: GOSUB 800: tohit = 8 - modi - combat
value = tohit - PE: GOSUB 1010
value = tohit - CL: GOSUB 1010
value = tohit - SH: GOSUB 1010
value = tohit - ME: GOSUB 1010
PRINT: PRINT
90
PRINT " "; Weapon$;
PRINT USING "##D6"; damage;
IF daema <> 0 THEN PRINT USING "+#"; dama;
value = DEXTERITY: GOSUB 800: tohit = 8 - modi - combat
IF tohit - PE > -9 AND tohit - PE < 13 THEN PRINT USING ", Close##+"; tohit - PE;
PRINT USING ", Extended##+"; tohit - CL;
IF tohit - SH > 0 AND tohit - SH < 13 THEN PRINT USING ", Short##+"; tohit - SH;
IF tohit - ME > 0 AND tohit - ME < 13 THEN PRINT USING ", Medium##+"; tohit - ME;
PRINT: PRINT: PRINT

LOCATE 24, 1: PRINT " Press <P> to generate a DOC";
GOSUB 1000
IF a$ = "P" THEN nnn = 1: OPEN subtype$ + ", " + character$ + ".doc" FOR OUTPUT AS #1: GOTO 900
RUN


900
CLS
IF CHOICE < 7 THEN PRINT #nnn, World$ + ", " + terrain$ + "," + STR$(number) + " x " + mmx$ + " " + subtype$

IF CHOICE = 7 THEN text$ = STR$(number) + " x " + mmx$ + " " + subtype$: GOSUB 19999

PRINT #nnn,
text$ = speed$ + " " + typ$ + ", the size of a " + size$ + "," + armor$ + "and armed with " + Weapon$ + ". " + animal$: GOSUB 19999

PRINT #nnn,
PRINT #nnn, character$; ","; Weight; "kg, Speed:"; Speed; ", Armor :"; Armor
PRINT #nnn,
PRINT #nnn, "ÚÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿"
PRINT #nnn, "³   STR   ³   DEX   ³   END   ³   INT   ³   INS   ³   PCK   ³"
PRINT #nnn, "ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄ´"
PRINT #nnn, USING "³   ##    ³   ##    ³   ##    ³   ##    ³   ##    ³   ##    ³"; STRENGTH; DEXTERITY; ENDURANCE; INTELLIGENCE, INSTINCT; PACK
IF CT = 1 GOTO 30015
PRINT #nnn, "ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄ´"
value = STRENGTH: GOSUB 800
IF modi <> 0 THEN PRINT #nnn, USING "³   +#    "; modi; ELSE PRINT #nnn, "³         ";

value = DEXTERITY: GOSUB 800
IF modi <> 0 THEN PRINT #nnn, USING "³   +#    "; modi; ELSE PRINT #nnn, "³         ";
value = ENDURANCE: GOSUB 800
IF modi <> 0 THEN PRINT #nnn, USING "³   +#    "; modi; ELSE PRINT #nnn, "³         ";
value = INTELLIGENCE: GOSUB 800
IF modi <> 0 THEN PRINT #nnn, USING "³   +#    "; modi; ELSE PRINT #nnn, "³         ";
value = INSTINCT: GOSUB 800
IF modi <> 0 THEN PRINT #nnn, USING "³   +#    "; modi; ELSE PRINT #nnn, "³         ";
value = PACK: GOSUB 800
IF modi <> 0 THEN PRINT #nnn, USING "³   +#    ³"; modi ELSE PRINT #nnn, "³         ³"
30015
PRINT #nnn, "ÀÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÙ"



'value = STRENGTH: GOSUB 800: PRINT #nnn, USING "Strength    ##/##"; STRENGTH; modi
'value = DEXTERITY: GOSUB 800: PRINT #nnn, USING "Dexterity   ##/##"; DEXTERITY; modi
'value = ENDURANCE: GOSUB 800: PRINT #nnn, USING "Endurance   ##/##"; ENDURANCE; modi
'value = INTELLIGENCE: GOSUB 800: PRINT #nnn, USING "Intelligence##/##"; INTELLIGENCE; modi
'value = INSTINCT: GOSUB 800: PRINT #nnn, USING "Instinct    ##/##"; INSTINCT; modi
'value = PACK: GOSUB 800: PRINT #nnn, USING "Pack        ##/##"; PACK; modi
PRINT #nnn,
PRINT #nnn, USING "Attack ##+/Flight##"; ATTACK; Fleeminus;: PRINT #nnn, "-"
PRINT #nnn,
PRINT #nnn, USING "Athletics+# "; -Athletics;
IF Recon > 0 THEN PRINT #nnn, USING "Recon+# "; -Recon;
IF Survival > 0 THEN PRINT #nnn, USING "Survival+# "; -Survival;
PRINT #nnn,
GOTO 91
PRINT #nnn,
PRINT #nnn,
PRINT #nnn, " "; Weapon$; SPC(17 - LEN(Weapon$));
PRINT #nnn, "³  1.5 m ³    3 m ³   12 m ³   50 m ³"
PRINT #nnn, "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄ´"
PRINT #nnn, USING "##D6"; damage;
IF dama <> 0 THEN PRINT #nnn, USING "+#"; dama; ELSE PRINT #nnn, "  ";
PRINT #nnn, SPC(12); "³ ";
tohit = 8 - modi - combat
value = tohit - PE: GOSUB 1010
value = tohit - CL: GOSUB 1010
value = tohit - SH: GOSUB 1010
value = tohit - ME: GOSUB 1010
91
PRINT #nnn,
PRINT #nnn, Weapon$;
PRINT #nnn, USING "##D6"; damage;
IF dama <> 0 THEN PRINT #nnn, USING "+#"; dama;
value = DEXTERITY: GOSUB 800: tohit = 8 - modi - combat
IF tohit - PE > -9 THEN PRINT #nnn, USING ", Close##+"; tohit - PE;
PRINT #nnn, USING ", Extended##+"; tohit - CL;
IF tohit - SH > 0 AND tohit - SH < 13 THEN PRINT #nnn, USING ", Short##+"; tohit - SH;
IF tohit - ME > 0 AND tohit - ME < 13 THEN PRINT #nnn, USING ", Medium##+"; tohit - ME;
PRINT #nnn,
PRINT #nnn,
PRINT #nnn, "HITPOINTS/WOUNDS";: IF Armor > 0 THEN PRINT #nnn, " - ARMOR :"; Armor ELSE PRINT #nnn,
PRINT #nnn,
PRINT #nnn, USING "MINOR   ##  "; ENDURANCE;
value = ENDURANCE: GOSUB 890
wound = STRENGTH: wound2 = DEXTERITY: IF DEXTERITY > STRENGTH THEN wound2 = STRENGTH: wound = DEXTERITY
PRINT #nnn,
PRINT #nnn, USING "WOUNDED ##  "; wound;
value = wound: GOSUB 890
PRINT #nnn,
PRINT #nnn, USING "SERIOUS ##  "; wound2;
value = wound2: GOSUB 890

GOTO 699
RUN

1010 IF nnn = 1 GOTO 1020
'IF value < 13 THEN value = 14 - value
IF value < 2 THEN value = 2
IF value < 13 AND value > 1 THEN PRINT USING "  ##+  ³ "; value;: RETURN
PRINT "   -   ³ ";: RETURN

1020
IF value < 2 THEN value = 2
IF value < 13 AND value > 1 THEN PRINT #nnn, USING "  ##+  ³ "; value;: RETURN
PRINT #nnn, "   -   ³ ";: RETURN



















































555
CLS
PRINT SPC(18); "G D W  R P G  Character Explanator"
LOCATE 11, 35

PRINT " SDEIES"
LOCATE 13, 35
INPUT " ", character$
PRINT
LOCATE 16, 32
PRINT " Male / Female"
GOSUB 1000


IF character$ = "" THEN GOSUB 2000: GOTO 100 'CHARACTER$ = "63906B"

value$ = MID$(character$, 1, 1): GOSUB 50: STRENGTH = value
value$ = MID$(character$, 2, 1): GOSUB 50: DEXTERITY = value
value$ = MID$(character$, 3, 1): GOSUB 50: ENDURANCE = value
value$ = MID$(character$, 4, 1): GOSUB 50: INTELLIGENCE = value
value$ = MID$(character$, 5, 1): GOSUB 50: EDUCATION = value
value$ = MID$(character$, 6, 1): GOSUB 50: SOCIAL = value


100 'Character Explanation
Gender$ = "He": gender2$ = "he": gender3$ = "His"
IF a$ = "f" OR a$ = "F" THEN Gender$ = "She": gender2$ = "she": gender3$ = "Her"




CLS

character$ = UCASE$(LEFT$(character$, 6))
'C1 STREnGTH
'Str Equivalent
IF STRENGTH = 0 THEN strength$ = Gender$ + " is so weak he is actually immobile"
IF STRENGTH = 1 THEN strength$ = eGender$ + " is extremly weak"
IF STRENGTH = 2 THEN strength$ = Gender$ + " is very weak (comparable to a 4 year old)"
IF STRENGTH = 3 THEN strength$ = Gender$ + " is really weak (comparable to a 6 year old)"
IF STRENGTH = 4 THEN strength$ = Gender$ + " is weak (comparable to a 10 year old)"
IF STRENGTH = 5 THEN strength$ = Gender$ + " is relativly weak (comparable to a 13 year old)"
IF STRENGTH = 6 THEN strength$ = Gender$ + " is a little bit on the weak side"
IF STRENGTH = 7 THEN strength$ = Gender$ + " is of average strength"
IF STRENGTH = 8 THEN strength$ = Gender$ + " is stronger than average"
IF STRENGTH = 9 THEN strength$ = Gender$ + " has a well muscled body"
IF STRENGTH = 10 THEN strength$ = Gender$ + " has a rugged strength"
IF STRENGTH = 11 THEN strength$ = Gender$ + " is very strong"
IF STRENGTH = 12 THEN strength$ = Gender$ + " is extremly strong"
IF STRENGTH = 13 THEN strength$ = Gender$ + " is of remarkable strength"
IF STRENGTH = 14 THEN strength$ = Gender$ + " is of extraordinary strength"
IF STRENGTH = 15 THEN strength$ = Gender$ + " is of superhuman strength"

'C2 DExTERiTy
'Dex Equivalent
IF DEXTERITY = 0 THEN dexterity$ = "has butterfingers"
IF DEXTERITY = 1 THEN dexterity$ = "is extremly clumsy"
IF DEXTERITY = 2 THEN dexterity$ = "is very clumsy"
IF DEXTERITY = 3 THEN dexterity$ = "is clumsy"
IF DEXTERITY = 4 THEN dexterity$ = "is unhandy"
IF DEXTERITY = 5 THEN dexterity$ = "is not very dextrous"
IF DEXTERITY = 6 THEN dexterity$ = "has a below average dexterity"
IF DEXTERITY = 7 THEN dexterity$ = "has an average dexterity"
IF DEXTERITY = 8 THEN dexterity$ = "has an above average dexterity"
IF DEXTERITY = 9 THEN dexterity$ = "has a high dexterity"
IF DEXTERITY = 10 THEN dexterity$ = "is adroit"
IF DEXTERITY = 11 THEN dexterity$ = "is very dextrous"
IF DEXTERITY = 12 THEN dexterity$ = "is extremly dextrous"
IF DEXTERITY = 13 THEN dexterity$ = "has a remarkable dexterity"
IF DEXTERITY = 14 THEN dexterity$ = "has a extraordinary dexterity"
IF DEXTERITY = 15 THEN dexterity$ = "has a superhuman dexterity"

IF DEXTERITY - STRENGTH < -1 THEN dexterity$ = "but " + dexterity$: GOTO 110
IF DEXTERITY - STRENGTH > 1 THEN dexterity$ = "and in addition " + dexterity$: GOTO 110
dexterity$ = "and " + dexterity$


'dexterity$ = Gender$ + " " + dexterity$
'IF DEXTERITY - STRENGTH < -3 THEN dexterity$ = "but " + gender2$ + " " + dexterity$: GOTO 110
'dexterity$ = "and " + gender2$ + " " + dexterity$
110

AGILITY = INT((STRENGTH + DEXTERITY) / 2)
'C2 AGiliTy
'Agi Equivalent
IF AGILITY = 0 THEN AGILITY$ = " and is effectively paralyzed"
IF AGILITY = 1 THEN AGILITY$ = " and moves like a snail"
IF AGILITY = 2 THEN AGILITY$ = " and has an extremly low agility"
IF AGILITY = 3 THEN AGILITY$ = " and has a very low agility"
IF AGILITY = 4 THEN AGILITY$ = " and has a low agility"
IF AGILITY = 5 THEN AGILITY$ = " and has a below average agility"
'IF AGILITY = 6 THEN AGILITY$ = ", has a slightly below average agility"
'IF AGILITY = 7 THEN AGILITY$ = " and average agility"
'IF AGILITY = 8 THEN AGILITY$ = "and has slightly above average agility"
IF AGILITY = 9 THEN AGILITY$ = " and is quite nimble"
IF AGILITY = 10 THEN AGILITY$ = " and is very nimble"
IF AGILITY = 11 THEN AGILITY$ = " and is really agile"
IF AGILITY = 12 THEN AGILITY$ = " and is extremly agile"
IF AGILITY = 13 THEN AGILITY$ = " and has a really remarkable agility"
IF AGILITY = 14 THEN AGILITY$ = " and has an extraordinary agility"
IF AGILITY = 15 THEN AGILITY$ = " and has a superhuman agility"


dexterity$ = dexterity$ + AGILITY$

grace = INT((INTELLIGENCE + DEXTERITY) / 2)
'C2 GRACE
'Gra Equivalent
IF grace = 0 THEN grace$ = ". " + Gender$ + " is a klutz."
IF grace = 1 THEN grace$ = ". " + Gender$ + " is terribly awkward."
IF grace = 2 THEN grace$ = ". " + Gender$ + " is extremly ungraceful."
IF grace = 3 THEN grace$ = ". " + Gender$ + " is very ungraceful"
IF grace = 4 THEN grace$ = ". " + Gender$ + " is ungraceful."
IF grace = 5 THEN grace$ = ". " + Gender$ + " is not very graceful."
IF grace = 6 THEN grace$ = "."
IF grace = 7 THEN grace$ = "."
IF grace = 8 THEN grace$ = "."
IF grace = 9 THEN grace$ = ". " + Gender$ + " is graceful."
IF grace = 10 THEN grace$ = ". " + Gender$ + " is really graceful."
IF grace = 11 THEN grace$ = ". " + Gender$ + " is very graceful."
IF grace = 12 THEN grace$ = ". " + Gender$ + " is exeptionally graceful."
IF grace = 13 THEN grace$ = ". " + Gender$3 + " grace is remarkable."
IF grace = 14 THEN grace$ = ". " + Gender$3 + " grace is extraordinary."
IF grace = 15 THEN grace$ = ". " + gender3$ + " grace is superhuman."

dexterity$ = dexterity$ + grace$
'C3 EnDURAnCE
'END Equivalent
IF ENDURANCE = 0 THEN endurance$ = Gender$ + " is comatose"
IF ENDURANCE = 1 THEN endurance$ = Gender$ + " is very Lethargic"
IF ENDURANCE = 2 THEN endurance$ = Gender$ + " is extremly easily fatigued"
IF ENDURANCE = 3 THEN endurance$ = Gender$ + " is very easily fatigued"
IF ENDURANCE = 4 THEN endurance$ = Gender$ + " is easily fatigued"
IF ENDURANCE = 5 THEN endurance$ = Gender$ + " has a below average endurance"
IF ENDURANCE = 6 THEN endurance$ = Gender$ + " has a slightly below average endurance"
IF ENDURANCE = 7 THEN endurance$ = Gender$ + " has an average endurance"
IF ENDURANCE = 8 THEN endurance$ = Gender$ + " has a slightly above average endurance"
IF ENDURANCE = 9 THEN endurance$ = Gender$ + " has a well above average endurance"
IF ENDURANCE = 10 THEN endurance$ = Gender$ + " has a good endurance"
IF ENDURANCE = 11 THEN endurance$ = Gender$ + " has a great Endurance"
IF ENDURANCE = 12 THEN endurance$ = Gender$ + " has a very high Endurance"
IF ENDURANCE = 13 THEN endurance$ = Gender$ + " has a remarkable endurance"
IF ENDURANCE = 14 THEN endurance$ = Gender$ + " has a extraordinary endurance"
IF ENDURANCE = 15 THEN endurance$ = Gender$ + " has a superhuman endurance"


'PRINT endurance$

stamina = INT((STRENGTH + INTELLIGENCE + ENDURANCE) / 3)
'C3 STAMinA
'Sta Equivalent
IF stamina = 0 THEN stamina$ = "0 Comatose"
IF stamina = 1 THEN stamina$ = "1 Very Lethargic"
IF stamina = 2 THEN stamina$ = "2 Quite Lethargic"
IF stamina = 3 THEN stamina$ = "3 Lethargic"
IF stamina = 4 THEN stamina$ = "4 Easily Fatigued"
IF stamina = 5 THEN stamina$ = "5 Below Average"
IF stamina = 6 THEN stamina$ = "6 Average"
IF stamina = 7 THEN stamina$ = "7 Average"
IF stamina = 8 THEN stamina$ = "8 Average"
IF stamina = 9 THEN stamina$ = "9 Above Average"
IF stamina = 10 THEN stamina$ = "A Above Average"
IF stamina = 11 THEN stamina$ = "B Great Stamina"
IF stamina = 12 THEN stamina$ = "C High Stamina"
IF stamina = 13 THEN stamina$ = "D Remarkable"
IF stamina = 14 THEN stamina$ = "E Extraordinary"
IF stamina = 15 THEN stamina$ = "F Superhuman"
stamina$ = "STAMINA:" + stamina$
'PRINT stamina$

vigor = INT((STRENGTH + ENDURANCE) / 2)
'C3 ViGoR
'Vig Equivalent
IF vigor = 0 THEN vigor$ = "and factually comatose"
IF vigor = 1 THEN vigor$ = "and always sick!"
IF vigor = 2 THEN vigor$ = "and has an extremely feeble health."
IF vigor = 3 THEN vigor$ = "and has a very feeble health."
IF vigor = 4 THEN vigor$ = "and has a feeble health."
IF vigor = 5 THEN vigor$ = "and has a weak health."
IF vigor = 6 THEN vigor$ = "and has a below average health."
IF vigor = 7 THEN vigor$ = "and has an average health."
IF vigor = 8 THEN vigor$ = "and has an above average health."
IF vigor = 9 THEN vigor$ = "and has a high vitality."
IF vigor = 10 THEN vigor$ = "and is an especially vigourus person."
IF vigor = 11 THEN vigor$ = "and is an extremly vigorous person."
IF vigor = 12 THEN vigor$ = "and has a remarkable Vigor."
IF vigor = 13 THEN vigor$ = "and has a really remarkable Vigor."
IF vigor = 14 THEN vigor$ = "and has a extraordinary Vigor."
IF vigor = 15 THEN vigor$ = "and has a superhuman Vigor."

'vigor$ = Gender$ + " " + vigor$
endurance$ = endurance$ + " " + vigor$


'C4 intelligence
'Int Equivalent
IF INTELLIGENCE = 0 THEN INTELLIGENCE$ = "is dumb as shit."
IF INTELLIGENCE = 1 THEN INTELLIGENCE$ = "has an IQ of 20. Can breathe without assistance."
IF INTELLIGENCE = 2 THEN INTELLIGENCE$ = "has an IQ of 40. Feeble minded."
IF INTELLIGENCE = 3 THEN INTELLIGENCE$ = "has an IQ of 60. Mentally retarded."
IF INTELLIGENCE = 4 THEN INTELLIGENCE$ = "has an IQ of 70. Unimaginative."
IF INTELLIGENCE = 5 THEN INTELLIGENCE$ = "has an IQ of 80, below average."
IF INTELLIGENCE = 6 THEN INTELLIGENCE$ = "has an IQ of 90, slightly below average."
IF INTELLIGENCE = 7 THEN INTELLIGENCE$ = "has an average IQ of 100."
IF INTELLIGENCE = 8 THEN INTELLIGENCE$ = "has an IQ of 110, slightly above average."
IF INTELLIGENCE = 9 THEN INTELLIGENCE$ = "has an IQ of 120, well above average."
IF INTELLIGENCE = 10 THEN INTELLIGENCE$ = "has a superior IQ of 130."
IF INTELLIGENCE = 11 THEN INTELLIGENCE$ = "has an IQ of 140. Gifted."
IF INTELLIGENCE = 12 THEN INTELLIGENCE$ = "has an IQ of 160. Very Gifted."
IF INTELLIGENCE = 13 THEN INTELLIGENCE$ = "has an IQ of 180. Genius."
IF INTELLIGENCE = 14 THEN INTELLIGENCE$ = "has an IQ of 200. Extraordinary."
IF INTELLIGENCE = 15 THEN INTELLIGENCE$ = "has an IQ of more than 200. Superhuman."
INTELLIGENCE$ = Gender$ + " " + INTELLIGENCE$

IF name$ <> "" THEN PRINT " "; name$; " -";
PRINT " "; character$;: IF Rank > 0 THEN PRINT " - "; Rank$(Rank);
PRINT
'PRINT STRENGTH; DEXTERITY; ENDURANCE; INTELLIGENCE; EDUCATION; SOCIAL
GOTO 80
PRINT " "; strength$
PRINT
PRINT " "; dexterity$
PRINT
PRINT " "; endurance$
PRINT
PRINT " "; INTELLIGENCE$
80
GOSUB 999
weight$ = Gender$ + " weighs" + STR$(INT(gewicht)) + " kg."
text$ = strength$ + " " + dexterity$ + " " + endurance$ + " " + weight$: GOSUB 19999

'gewicht
'PRINT " BODY      :"; CINT(body)


'PRINT text$


PRINT
'C5 EDUCATion
'Edu Equivalent
IF EDUCATION = 0 THEN education$ = Gender$ + " has never visited a school"
IF EDUCATION = 1 THEN education$ = Gender$ + " is iIlliterate"
IF EDUCATION = 2 THEN education$ = Gender$ + " can read but not write"
IF EDUCATION = 3 THEN education$ = Gender$ + " has finished Grade School"
IF EDUCATION = 4 THEN education$ = Gender$ + " is a High school Dropout"
IF EDUCATION = 5 THEN education$ = Gender$ + " has finished High School"
IF EDUCATION = 6 THEN education$ = Gender$ + " has visited a College"
IF EDUCATION = 7 THEN education$ = Gender$ + " has a College degree"
IF EDUCATION = 8 THEN education$ = Gender$ + " has a Bachelor degree"
IF EDUCATION = 9 THEN education$ = Gender$ + " has a Master degree"
IF EDUCATION = 10 THEN education$ = Gender$ + " has a Master degree, did advanced work"
IF EDUCATION = 11 THEN education$ = Gender$ + " has a Master degree, worked in Research"
IF EDUCATION = 12 THEN education$ = Gender$ + " has a Doctorate"
IF EDUCATION = 13 THEN education$ = Gender$ + " has a Doctorate, an Expert in his subject"
IF EDUCATION = 14 THEN education$ = Gender$ + " has a Doctorate, An Authority in his subject"
IF EDUCATION = 15 THEN education$ = Gender$ + " has a Doctorate, The Authority in his subject"

training = INT((EDUCATION + DEXTERITY) / 2)
'C5 TRAininG
'Tra Equivalent
IF training = 0 THEN training$ = ", but is incapable to use this knowledge in practice."
IF training < 3 THEN training$ = ", but is nearly incapable to use this knowledge in practice."
IF training < 5 THEN training$ = ", but has huge problems to use this knowledge in practice."
IF training < 7 THEN training$ = ", but has problems to use this knowledge in practice."
IF training = 7 THEN training$ = ", and can adequately use this knowledge in practice."
IF training > 7 THEN training$ = ", and has the knack how to use this knowledge in practice."
IF training > 9 THEN training$ = ", and is really good in using this knowledge in practice."
IF training > 11 THEN training$ = ", and is extremly good in using this knowledge in practice."
IF training > 13 THEN training$ = ", and is adept at using this knowledge in practice."
IF training = 15 THEN training$ = ", and is very adept at using this knowledge in practice."

'Instinct (Ins). Instinct is an inborn complex of behaviors comparable to acquired learning.
'It is based on genetic 'heritage. Sophonts with C5 = Instinct function poorly in the
'Education or Training environment and cannot use those institutions (they increase skills through experience).

INSTINCT = INT((INTELLIGENCE + DEXTERITY) / 2)
'C5 inSTinCT
'Ins Equivalent
IF INSTINCT = 0 THEN INSTINCT$ = "0 Lacking any instinct."
IF INSTINCT = 1 THEN INSTINCT$ = "1 Incapable"
IF INSTINCT = 2 THEN INSTINCT$ = "2 Very Slow"
IF INSTINCT = 3 THEN INSTINCT$ = "3 Slow"
IF INSTINCT = 4 THEN INSTINCT$ = "4 Slow"
IF INSTINCT = 5 THEN INSTINCT$ = "5 Below Average"
IF INSTINCT = 6 THEN INSTINCT$ = "6 Below Average"
IF INSTINCT = 7 THEN INSTINCT$ = "7 Average"
IF INSTINCT = 8 THEN INSTINCT$ = "8 Above Average"
IF INSTINCT = 9 THEN INSTINCT$ = "9 Above Average"
IF INSTINCT = 10 THEN INSTINCT$ = "A Resourceful"
IF INSTINCT = 11 THEN INSTINCT$ = "B Resourceful"
IF INSTINCT = 12 THEN INSTINCT$ = "C Very Resourceful"
IF INSTINCT = 13 THEN INSTINCT$ = "D Extremly Resourceful"
IF INSTINCT = 14 THEN INSTINCT$ = "E Adept"
IF INSTINCT = 15 THEN INSTINCT$ = "F Very Adept"
INSTINCT$ = ""
'INSTINCT$ = "Instinct = " + INSTINCT$


'C6 SoCiAl
'Soc Equivalent
IF SOCIAL = 0 THEN social$ = "Social Outcast"
IF SOCIAL = 1 THEN social$ = "Social Misfit"
IF SOCIAL = 2 THEN social$ = "Dregs of Society"
IF SOCIAL = 3 THEN social$ = "Lowest Lower Class"
IF SOCIAL = 4 THEN social$ = "Lower Class"
IF SOCIAL = 5 THEN social$ = "Upper Lower Class"
IF SOCIAL = 6 THEN social$ = "Lower Middle Class"
IF SOCIAL = 7 THEN social$ = "Middle Class"
IF SOCIAL = 8 THEN social$ = "Upper Middle Class"
IF SOCIAL = 9 THEN social$ = "Lower High Society"
IF SOCIAL = 10 THEN social$ = "High Society"
IF SOCIAL = 11 THEN social$ = "Member of the 1%"
IF SOCIAL = 12 THEN social$ = "Remarkable"
IF SOCIAL = 13 THEN social$ = "Extraordinary"
IF SOCIAL = 14 THEN social$ = "Extreme"
IF SOCIAL = 15 THEN social$ = "Supreme"

IF SOCIAL < 2 THEN socs$ = "criminal"
IF SOCIAL = 2 THEN socs$ = "scum"
IF SOCIAL = 3 THEN socs$ = "Lowest Underclass"
IF SOCIAL = 4 THEN socs$ = "lower class"
IF SOCIAL = 5 THEN socs$ = "Lower middle class"
IF SOCIAL = 6 THEN socs$ = "middle class"
IF SOCIAL = 7 THEN socs$ = "Upper middle class"
IF SOCIAL = 8 THEN socs$ = "Better earning"
IF SOCIAL = 9 THEN socs$ = "upper middle class"
IF SOCIAL = 10 THEN socs$ = "High Society"
IF SOCIAL = 11 THEN socs$ = "Knight (Sir / Lady)"
IF SOCIAL = 12 THEN socs$ = "Baron (from / hault)"
IF SOCIAL = 13 THEN socs$ = "Marquis"
IF SOCIAL = 14 THEN socs$ = "Count"
IF SOCIAL = 15 THEN socs$ = "Duke"
IF SOCIAL = 16 THEN socs$ = "Archduke"
IF SOCIAL > 16 THEN socs$ = "Emperor"



CHARISMA = INT((SOCIAL + grace) / 2)
'C6 CHARiSMA
'Cha Equivalent
IF CHARISMA = 0 THEN CHARISMA$ = " is extremely shy."
IF CHARISMA = 1 THEN CHARISMA$ = " is extremely shy."
IF CHARISMA = 2 THEN CHARISMA$ = " is extremely shy."
IF CHARISMA = 3 THEN CHARISMA$ = " is extremely shy."
IF CHARISMA = 4 THEN CHARISMA$ = " is very shy."
IF CHARISMA = 5 THEN CHARISMA$ = " is very shy."
IF CHARISMA = 6 THEN CHARISMA$ = " is shy."
IF CHARISMA = 7 THEN CHARISMA$ = ""
IF CHARISMA = 8 THEN CHARISMA$ = " is sympathetic."
IF CHARISMA = 9 THEN CHARISMA$ = " is very sympathetic."
IF CHARISMA = 10 THEN CHARISMA$ = " is charismatic."
IF CHARISMA = 11 THEN CHARISMA$ = " is a Leader."
IF CHARISMA = 12 THEN CHARISMA$ = " is a Strong Leader."
IF CHARISMA = 13 THEN CHARISMA$ = " is a very strong Leader."
IF CHARISMA = 14 THEN CHARISMA$ = " is a very impressive Leader."
IF CHARISMA > 14 THEN CHARISMA$ = " is a natural and compelling Leader."
IF CHARISMA$ <> "" THEN CHARISMA$ = Gender$ + CHARISMA$

IF CHARISMA < 2 THEN char$ = "Extremely shy"
IF CHARISMA = 2 THEN char$ = "very shy"
IF CHARISMA = 3 THEN char$ = "shy"
IF CHARISMA = 4 THEN char$ = "very shy"
IF CHARISMA = 5 THEN char$ = "Shocking"
IF CHARISMA = 6 THEN char$ = "average"
IF CHARISMA = 7 THEN char$ = "Nice"
IF CHARISMA = 8 THEN char$ = "Sympathetic"
IF CHARISMA = 9 THEN char$ = "Charismatic"
IF CHARISMA = 10 THEN char$ = "Very charismatic"
IF CHARISMA > 10 THEN char$ = "Extremely charismatic"



'C6 noBiliTy
'Soc Equivalent
nobility = SOCIAL
IF nobility < 10 THEN NOBILITY$ = "Commoner"
IF nobility = 10 THEN NOBILITY$ = "Member of the Gentry (A)"
IF nobility = 11 THEN NOBILITY$ = "Knight (B)"
IF nobility = 12 THEN NOBILITY$ = "Baron (C)"
IF nobility = 13 THEN NOBILITY$ = "Marquis (D)"
IF nobility = 14 THEN NOBILITY$ = "Count (E)"
IF nobility = 15 THEN NOBILITY$ = "Duke (F)"
IF nobility = 16 THEN NOBILITY$ = "Archduke (G)"
IF nobility = 17 THEN NOBILITY$ = "Emperor (H)"

text$ = INTELLIGENCE$ + " " + education$ + training$: GOSUB 19999
PRINT

'PRINT " EDUCATION : "; education$

social$ = social$ + ", " + NOBILITY$
PRINT " SOCIAL    : "; social$
PRINT
'PRINT " TRAINING  : "; training$

IF CHARISMA$ <> "" THEN PRINT " CHARISMA  : "; CHARISMA$
IF CHARISMA$ <> "" THEN PRINT
IF INSTINCT$ <> "" THEN PRINT " INSTINCT  : "; INSTINCT$
IF INSTINCT$ <> "" THEN PRINT
PRINT
'GOSUB 8000: char1$ = card$
'GOSUB 8000: char2$ = card$

'text$ = char1$: GOSUB 19999
'PRINT
'text$ = char2$: GOSUB 19999
'PRINT




880 IF nnn = 1 GOTO 885
GOTO 886
PRINT " HITPOINTS/WOUNDS";: IF Armor > 0 THEN PRINT " - ARMOR :"; Armor ELSE PRINT
PRINT
PRINT USING " MINOR   ##  "; ENDURANCE;
value = ENDURANCE: GOSUB 890
wound = STRENGTH: wound2 = DEXTERITY: IF DEXTERITY > STRENGTH THEN wound2 = STRENGTH: wound = DEXTERITY
PRINT
PRINT USING " WOUNDED ##  "; wound;
value = wound: GOSUB 890
PRINT
PRINT USING " SERIOUS ##  "; wound2;
value = wound2: GOSUB 890
IF Animal = 1 THEN RETURN
886

IF CHOICE = 8 THEN nnn = 1: OPEN character$ + ".doc" FOR OUTPUT AS #1: GOTO 30000

LOCATE 24, 1: PRINT " Press <P> to generate a DOC";
IF CHOICE = 6 THEN a$ = "P" ELSE GOSUB 1000
'IF choice = 1 THEN GOSUB 1000: ELSE a$ = "P"

IF a$ = "p" OR a$ = "P" THEN nnn = 1: OPEN name$ + " " + character$ + ".doc" FOR OUTPUT AS #1: GOTO 30000
RUN
GOTO 555


800
IF value < 1 THEN modi = -3: RETURN
IF value < 3 THEN modi = -2: RETURN
IF value < 6 THEN modi = -1: RETURN
IF value < 9 THEN modi = 0: RETURN
modi = INT((value - 9) / 3) + 1: RETURN





GOSUB 1000
RUN


'CS SAniTy
'San Equivalent
IF sanity = 0 THEN sanity$ = "0 Non-Functioning"
IF sanity = 1 THEN sanity$ = "1 Borderline"
IF sanity = 2 THEN sanity$ = "2 Vulnerable"
IF sanity = 3 THEN sanity$ = "3 Weak"
IF sanity = 4 THEN sanity$ = "4 At Risk"
IF sanity = 5 THEN sanity$ = "5 Sane"
IF sanity = 6 THEN sanity$ = "6 Sane"
IF sanity = 7 THEN sanity$ = "7 Sane. Normal."
IF sanity = 8 THEN sanity$ = "8 Sane"
IF sanity = 9 THEN sanity$ = "9 Sane"
IF sanity = 10 THEN sanity$ = "A Sane"
IF sanity = 11 THEN sanity$ = "B Sane"
IF sanity = 12 THEN sanity$ = "C Sane"



890 IF nnn = 1 GOTO 895
FOR I = 1 TO value

    PRINT "o";:
    IF value < 17 THEN PRINT " ";
    IF value < 21 THEN PRINT " ";
    IF value < 32 THEN PRINT " ";
NEXT: PRINT
RETURN

895
FOR I = 1 TO value
    PRINT #nnn, "o";:
    IF value < 17 THEN PRINT #nnn, " ";
    IF value < 21 THEN PRINT #nnn, " ";
    IF value < 32 THEN PRINT #nnn, " ";
NEXT: PRINT #nnn,
RETURN



50
IF value$ = "0" THEN value = 0: RETURN
IF VAL(value$) > 0 THEN value = VAL(value$): RETURN
IF value$ = "A" OR value$ = "a" THEN value = 10: RETURN
IF value$ = "B" OR value$ = "b" THEN value = 11: RETURN
IF value$ = "C" OR value$ = "c" THEN value = 12: RETURN
IF value$ = "D" OR value$ = "d" THEN value = 13: RETURN
IF value$ = "E" OR value$ = "e" THEN value = 14: RETURN
IF value$ = "F" OR value$ = "f" THEN value = 15: RETURN
RETURN


60
IF value < 1 THEN value$ = "0": RETURN
IF value = 1 THEN value$ = "1": RETURN
IF value = 2 THEN value$ = "2": RETURN
IF value = 3 THEN value$ = "3": RETURN
IF value = 4 THEN value$ = "4": RETURN
IF value = 5 THEN value$ = "5": RETURN
IF value = 6 THEN value$ = "6": RETURN
IF value = 7 THEN value$ = "7": RETURN
IF value = 8 THEN value$ = "8": RETURN
IF value = 9 THEN value$ = "9": RETURN
IF value = 10 THEN value$ = "A": RETURN
IF value = 11 THEN value$ = "B": RETURN
IF value = 12 THEN value$ = "C": RETURN
IF value = 13 THEN value$ = "D": RETURN
IF value = 14 THEN value$ = "E": RETURN
IF value = 15 THEN value$ = "F": RETURN
IF value = 16 THEN value$ = "G": RETURN
IF value = 17 THEN value$ = "H": RETURN
IF value = 18 THEN value$ = "J": RETURN
IF value = 19 THEN value$ = "K": RETURN
IF value = 20 THEN value$ = "L": RETURN
IF value = 21 THEN value$ = "M": RETURN
IF value = 22 THEN value$ = "N": RETURN
IF value = 23 THEN value$ = "P": RETURN
IF value = 24 THEN value$ = "Q": RETURN
IF value = 25 THEN value$ = "R": RETURN
IF value = 26 THEN value$ = "S": RETURN
IF value = 27 THEN value$ = "T": RETURN
IF value = 28 THEN value$ = "U": RETURN
IF value = 29 THEN value$ = "V": RETURN
IF value = 30 THEN value$ = "W": RETURN
IF value = 31 THEN value$ = "X": RETURN
IF value = 32 THEN value$ = "Y": RETURN
IF value > 32 THEN value$ = "Z": RETURN














RETURN




999 ' WEIGHT
'A male character's weight in kilograms is equal to 80, plus 4 times Strength minus Agility, or
'[4x(STR-AGL)]+80. Thus, a male character with a Strength of 6 and an Agility'of 1 would weigh 100
'kilograms(about 220pounds), while a male character with a Strength of 4 and an Agility of 8
'wouldweigh 64 kilograms (roughly 141 pounds).

'Physiological differences, particularly in bone structure, result in smaller body masses for women.
'Therefore, weightinkilogramsforfemale charactersiscalculated by substituting 65 for 80 in the formula, or
'[4x(STR-AGL)]+65. Thus, a female character with a Strength of 6 and an Agility of 1 would weigh 85
'kilograms(about 187 pounds), while a female character with a Strength of 4 and an Agility of 8 would weigh
'49 kilos (roughly 108pounds).

'Load: A person can lug a considerable weight of equipment even cross-country, but there is a limit In
'Traveller, charactersmaycarry, withoutbeingheavily burdened, a totalweightinkilogramsequalto 3 times
'the sum of their Strength and Constitution - (STR+CON)x3. This is called a character's normal load.
'Up to twice the normal load can be carried, but the character is considered burdened and has movement
'reduced, as explained on page 265 in the Personnel Movement section. A burdened character's Initiative
'is also temporarily reduced by 1(to a minimumof 1; see 'Initiative belowand on page 264).
'A charactermay LIFT loads up to 4 times the normal load and carry them short distances
'(50to 1009 meters at a time; Initiative is reduced to 1 while this load is carried). Note that
' multiple characters 'may add their loadcapacities to l i i h e w objects.

'Throw Range:The distance(in meters) a character can throw a one-kilogram weight accurately is called
'the character's throw range.Throwrange is 4 times the character's Strength (STRx4).



wm = 80: IF Gender$ = "She" THEN wm = 65
wm = 80: IF weba > 0 THEN wm = weba
wiba = STRENGTH - DEXTERITY: ' IF wiba < -2 THEN wiba = -2
wiba = DEXTERITY - ENDURANCE
stremod = (STRENGTH + ENDURANCE) / 12
IF stremod > 1.5 THEN stremod = 1.5
IF stremod < .75 THEN stremod = .75
gewicht = wiba * 4 / 1.5 + wm * stremod
gewicht = wiba * 4 + wm
BODY = SQR(gewicht * ENDURANCE / 5) / 1.789
BODY = (gewicht * ENDURANCE / 5) ^ .3673 * 1.4
LOAD = (STRENGTH + ENDURANCE) * 3
LIFT = LOAD * 4
RETURN

1000 a$ = UCASE$(INKEY$): IF a$ = "" GOTO 1000
'IF a$ = " " OR a$ = "Q" THEN END
IF a$ = "R" THEN RUN
RETURN






2000 character$ = ""
STRMOD = 0: DEXMOD = 0: ENDMOD = 0

IF race$ = "Aslan" THEN DXMOD = -2: STRMOD = 2
IF race$ = "Vargr" THEN DXMOD = 1: STRMOD = -1: ENDMOD = -1



STRENGTH = INT(RND * 6) + INT(RND * 6) + 2 + STRMOD
value = STRENGTH: GOSUB 60: character$ = character$ + value$


RANDOMIZE TIMER
DEXTERITY = INT(RND * 6) + INT(RND * 6) + 2 + DXMOD
value = DEXTERITY: GOSUB 60: character$ = character$ + value$


RANDOMIZE TIMER
ENDURANCE = INT(RND * 6) + INT(RND * 6) + 2 + ENDMOD
value = ENDURANCE: GOSUB 60: character$ = character$ + value$


INTELLIGENCE = INT(RND * 6) + INT(RND * 6) + 2
value = INTELLIGENCE: GOSUB 60: character$ = character$ + value$


EDUCATION = INT(RND * 6) + INT(RND * 6) + 2
value = EDUCATION: GOSUB 60: character$ = character$ + value$


SOCIAL = INT(RND * 6) + INT(RND * 6) + 2
value = SOCIAL: GOSUB 60: character$ = character$ + value$



RETURN




19999 ' Druckausgabe
IF LEFT$(text$, 1) = " " THEN text$ = RIGHT$(text$, LEN(text$) - 1): GOTO 19999

FOR i2 = 0 TO 10: text$(i2) = "": NEXT

tabu0 = 78: IF nnn = 1 THEN tabu0 = 1000
tabu = tabu0: tx = 0:
text$(0) = text$: IF LEN(text$(0)) <= tabu THEN GOTO 10004

10001 IF tabu > 1 AND MID$(text$(tx), tabu, 1) <> " " THEN tabu = tabu - 1: GOTO 10001
leng = LEN(text$(tx)): l1 = leng - tabu
text$(tx + 1) = RIGHT$(text$(tx), l1)
text$(tx) = LEFT$(text$(tx), tabu)
tx = tx + 1
tabu = tabu0
IF LEN(text$(tx)) > tabu THEN GOTO 10001
' IF tx < 2 THEN GOTO 10004

' GOTO 10004
10002 FOR i2 = 0 TO tx - 1: space0 = tabu0 - LEN(text$(i2)): work1$ = ""

    10003 work$ = text$(i2): work1$ = "":
    FOR zz = 1 TO LEN(work$): space0$ = MID$(work$, zz, 1)
        IF space0$ = " " AND space0 > 0 THEN space0$ = "  ": space0 = space0 - 1
        work1$ = work1$ + space0$
    NEXT
    text$(i2) = work1$
    IF space0 > 0 AND tx <> i2 THEN GOTO 10003

NEXT

10004 FOR i2 = 0 TO tx: ' IF i2 = 0 THEN PRINT " ";
    IF nnn = 1 THEN PRINT #nnn, text$(i2) ELSE PRINT " "; text$(i2)
NEXT
RETURN
10005
IF LEFT$(text$, 1) = " " THEN text$ = RIGHT$(text$, LEN(text$) - 1): GOTO 10005
RETURN











30000
' Character print version
GOSUB 8000: char1$ = card$
GOSUB 8000: char2$ = card$
character$ = ""
value = STRENGTH: GOSUB 60: character$ = character$ + value$
value = DEXTERITY: GOSUB 60: character$ = character$ + value$
value = ENDURANCE: GOSUB 60: character$ = character$ + value$
value = INTELLIGENCE: GOSUB 60: character$ = character$ + value$
value = EDUCATION: GOSUB 60: character$ = character$ + value$
value = SOCIAL: GOSUB 60: character$ = character$ + value$

IF name$ <> "" THEN PRINT #nnn, name$; " - ";
IF Rank > 0 THEN PRINT #nnn, Rank$(Rank): PRINT #nnn, ;

PRINT #nnn, character$;:
PRINT #nnn,
PRINT #nnn,
GOTO 40055
'GOTO 30006
'PRINT #nnn, "ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ¿"
'PRINT #nnn, "³  Strength ³  Dexterity ³  Endurance ³Intelligence³  Education ³  Social   ³"
'PRINT #nnn, "ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄ´"
'PRINT #nnn, USING "³  Str##gth ³  Dex##rity ³  End##ance ³Inte##igence³  Edu##tion ³  So##al   ³"; STRENGTH; DEXTERITY; ENDURANCE; INTELLIGENCE, EDUCATION; SOCIAL


PRINT #nnn, "ÚÄÄÄÂÄÄÄÂÄÄÄÂÄÄÄÂÄÄÄÂÄÄÄ¿"
PRINT #nnn, "³STR³DEX³END³INT³EDU³SOC³"
PRINT #nnn, "ÃÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄ´"
'PRINT #nnn, "³   ³         ³         ³         ³         ³         ³"
PRINT #nnn, USING "³## ³## ³## ³## ³## ³## ³"; STRENGTH; DEXTERITY; ENDURANCE; INTELLIGENCE, EDUCATION; SOCIAL
'PRINT #nnn, "³         ³         ³         ³         ³         ³         ³"
IF CT = 1 GOTO 300052
PRINT #nnn, "ÃÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄÅÄÄÄ´"

'PRINT #nnn, "³         ³         ³         ³         ³         ³         ³"
value = STRENGTH: GOSUB 800
IF modi <> 0 THEN PRINT #nnn, USING "³+# "; modi; ELSE PRINT #nnn, "³   ";
value = DEXTERITY: GOSUB 800
IF modi <> 0 THEN PRINT #nnn, USING "³+# "; modi; ELSE PRINT #nnn, "³   ";
value = ENDURANCE: GOSUB 800
IF modi <> 0 THEN PRINT #nnn, USING "³+# "; modi; ELSE PRINT #nnn, "³   ";
value = INTELLIGENCE: GOSUB 800
IF modi <> 0 THEN PRINT #nnn, USING "³+# "; modi; ELSE PRINT #nnn, "³   ";
value = EDUCATION: GOSUB 800
IF modi <> 0 THEN PRINT #nnn, USING "³+# "; modi; ELSE PRINT #nnn, "³   ";
value = SOCIAL: GOSUB 800
IF modi <> 0 THEN PRINT #nnn, USING "³+# ³"; modi ELSE PRINT #nnn, "³   ³"
'PRINT #nnn, "³         ³         ³         ³         ³         ³         ³"
300052
PRINT #nnn, "ÀÄÄÄÁÄÄÄÁÄÄÄÁÄÄÄÁÄÄÄÁÄÄÄÙ": ' GOTO 30009

PRINT #nnn, "ÚÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄ¿"
PRINT #nnn, "³  STR  ³  DEX  ³  END  ³  INT  ³  EDU  ³  SOC  ³"
PRINT #nnn, "ÃÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄ´"
PRINT #nnn, "³       ³       ³       ³       ³       ³       ³"
PRINT #nnn, USING "³  ##   ³  ##   ³  ##   ³  ##   ³  ##   ³  ##   ³"; STRENGTH; DEXTERITY; ENDURANCE; INTELLIGENCE, EDUCATION; SOCIAL
PRINT #nnn, "³       ³       ³       ³       ³       ³       ³"
IF CT = 1 GOTO 300056
PRINT #nnn, "ÃÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄ´"
value = STRENGTH: GOSUB 800
PRINT #nnn, "³       ³       ³       ³       ³       ³       ³"
IF modi <> 0 THEN PRINT #nnn, USING "³  +#   "; modi; ELSE PRINT #nnn, "³       ";
value = DEXTERITY: GOSUB 800
IF modi <> 0 THEN PRINT #nnn, USING "³  +#   "; modi; ELSE PRINT #nnn, "³       ";
value = ENDURANCE: GOSUB 800
IF modi <> 0 THEN PRINT #nnn, USING "³  +#   "; modi; ELSE PRINT #nnn, "³       ";
value = INTELLIGENCE: GOSUB 800
IF modi <> 0 THEN PRINT #nnn, USING "³  +#   "; modi; ELSE PRINT #nnn, "³       ";
value = EDUCATION: GOSUB 800
IF modi <> 0 THEN PRINT #nnn, USING "³  +#   "; modi; ELSE PRINT #nnn, "³       ";
value = SOCIAL: GOSUB 800
IF modi <> 0 THEN PRINT #nnn, USING "³  +#   ³"; modi ELSE PRINT #nnn, "³       ³"
PRINT #nnn, "³       ³       ³       ³       ³       ³       ³"
300056
PRINT #nnn, "ÀÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÙ"




40055
PRINT #nnn, "ÚÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿"
PRINT #nnn, "³   STR   ³   DEX   ³   END   ³   INT   ³   EDU   ³   SOC   ³"
PRINT #nnn, "ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄ´"
PRINT #nnn, "³         ³         ³         ³         ³         ³         ³"
PRINT #nnn, USING "³   ##    ³   ##    ³   ##    ³   ##    ³   ##    ³   ##    ³"; STRENGTH; DEXTERITY; ENDURANCE; INTELLIGENCE, EDUCATION; SOCIAL
PRINT #nnn, "³         ³         ³         ³         ³         ³         ³"
IF CT = 1 GOTO 30005
PRINT #nnn, "ÃÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄ´"
value = STRENGTH: GOSUB 800
PRINT #nnn, "³         ³         ³         ³         ³         ³         ³"
IF modi <> 0 THEN PRINT #nnn, USING "³   +#    "; modi; ELSE PRINT #nnn, "³         ";
value = DEXTERITY: GOSUB 800
IF modi <> 0 THEN PRINT #nnn, USING "³   +#    "; modi; ELSE PRINT #nnn, "³         ";
value = ENDURANCE: GOSUB 800
IF modi <> 0 THEN PRINT #nnn, USING "³   +#    "; modi; ELSE PRINT #nnn, "³         ";
value = INTELLIGENCE: GOSUB 800
IF modi <> 0 THEN PRINT #nnn, USING "³   +#    "; modi; ELSE PRINT #nnn, "³         ";
value = EDUCATION: GOSUB 800
IF modi <> 0 THEN PRINT #nnn, USING "³   +#    "; modi; ELSE PRINT #nnn, "³         ";
value = SOCIAL: GOSUB 800
IF modi <> 0 THEN PRINT #nnn, USING "³   +#    ³"; modi ELSE PRINT #nnn, "³         ³"
PRINT #nnn, "³         ³         ³         ³         ³         ³         ³"
30005
PRINT #nnn, "ÀÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÙ"
GOTO 30009



30006
PRINT #nnn, "ÚÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄ¿"
PRINT #nnn, "³           ³           ³           ³           ³           ³           ³"
PRINT #nnn, "³    STR    ³    DEX    ³    END    ³    INT    ³    EDU    ³    SOC    ³"
PRINT #nnn, "³           ³           ³           ³           ³           ³           ³"
PRINT #nnn, "ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄ´"
PRINT #nnn, "³           ³           ³           ³           ³           ³           ³"
PRINT #nnn, USING "³    ##     ³    ##     ³    ##     ³    ##     ³    ##     ³    ##     ³"; STRENGTH; DEXTERITY; ENDURANCE; INTELLIGENCE, EDUCATION; SOCIAL
PRINT #nnn, "³           ³           ³           ³           ³           ³           ³"
IF CT = 1 GOTO 300051
PRINT #nnn, "ÃÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄ´"
PRINT #nnn, "³           ³           ³           ³           ³           ³           ³"

value = STRENGTH: GOSUB 800
IF modi <> 0 THEN PRINT #nnn, USING "³    +#     "; modi; ELSE PRINT #nnn, "³           ";
value = DEXTERITY: GOSUB 800
IF modi <> 0 THEN PRINT #nnn, USING "³    +#     "; modi; ELSE PRINT #nnn, "³           ";
value = ENDURANCE: GOSUB 800
IF modi <> 0 THEN PRINT #nnn, USING "³    +#     "; modi; ELSE PRINT #nnn, "³           ";
value = INTELLIGENCE: GOSUB 800
IF modi <> 0 THEN PRINT #nnn, USING "³    +#     "; modi; ELSE PRINT #nnn, "³           ";
value = EDUCATION: GOSUB 800
IF modi <> 0 THEN PRINT #nnn, USING "³    +#     "; modi; ELSE PRINT #nnn, "³           ";
value = SOCIAL: GOSUB 800
IF modi <> 0 THEN PRINT #nnn, USING "³    +#     ³"; modi ELSE PRINT #nnn, "³           ³"

300051

PRINT #nnn, "³           ³           ³           ³           ³           ³           ³"
PRINT #nnn, "ÀÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÙ"
30009



'value = STRENGTH: GOSUB 800: PRINT #nnn, USING "Strength    ##/+#"; STRENGTH; modi
'value = DEXTERITY: GOSUB 800: PRINT #nnn, USING "Dexterity   ##/+#"; DEXTERITY; modi
'value = ENDURANCE: GOSUB 800: PRINT #nnn, USING "Endurance   ##/+#"; ENDURANCE; modi
'value = INTELLIGENCE: GOSUB 800: PRINT #nnn, USING "Intelligence##/+#"; INTELLIGENCE; modi
'value = EDUCATION: GOSUB 800: PRINT #nnn, USING "Education   ##/+#"; EDUCATION; modi
'value = SOCIAL: GOSUB 800: PRINT #nnn, USING "Social      ##/+#"; SOCIAL; modi
PRINT #nnn,

30010
GOSUB 999
weight$ = Gender$ + " weighs" + STR$(INT(gewicht)) + " kg."
text$ = strength$ + " " + dexterity$ + " " + endurance$ + " " + weight$: GOSUB 19999
PRINT #nnn,
text$ = INTELLIGENCE$ + " " + education$ + training$: GOSUB 19999
PRINT #nnn,
PRINT #nnn, "SOCIAL    : "; social$
IF CHARISMA$ <> "" THEN PRINT #nnn,
IF CHARISMA$ <> "" THEN PRINT #nnn, "CHARISMA  : "; CHARISMA$
IF INSTINCT$ <> "" THEN PRINT #nnn,
IF INSTINCT$ <> "" THEN PRINT #nnn, "INSTINCT  : "; INSTINCT$
PRINT #nnn,
text$ = char1$: GOSUB 19999
PRINT #nnn,
text$ = char2$: GOSUB 19999
PRINT #nnn,
885
PRINT #nnn,
PRINT #nnn, "HITPOINTS/WOUNDS";: IF Armor > 0 THEN PRINT #nnn, " - ARMOR :"; Armor ELSE PRINT #nnn,
PRINT #nnn,
PRINT #nnn, USING "MINOR   ##  "; ENDURANCE;
value = ENDURANCE: GOSUB 890
wound = STRENGTH: wound2 = DEXTERITY: IF DEXTERITY > STRENGTH THEN wound2 = STRENGTH: wound = DEXTERITY
PRINT #nnn,
PRINT #nnn, USING "WOUNDED ##  "; wound;
value = wound: GOSUB 890
PRINT #nnn,
PRINT #nnn, USING "SERIOUS ##  "; wound2;
value = wound2: GOSUB 890
IF Animal = 1 THEN RETURN
IF CSKILL = 0 THEN GOTO 30030
699
IF CHOICE <> 8 GOTO 6999
PRINT #nnn,
FOR x = 1 TO year: PRINT #nnn, USING "##."; x + 17;: PRINT #nnn, " "; year$(x): NEXT
PRINT #nnn,
IF mcuf > 0 THEN PRINT #nnn, " Meritorious conduct under Fire x"; mcuf
IF mcg > 0 THEN PRINT #nnn, " Medal for conspicous Gallantry x"; mcg
IF seh > 0 THEN PRINT #nnn, " Starburst for Extreme Heroism x"; mcuf

6999
PRINT #nnn,
PRINT #nnn,
PRINT #nnn, "S K I L L S"
PRINT #nnn,
700 'SKILLS

FOR rate = 10 TO -1 STEP -1
    FOR a1 = 65 TO 90
        FOR a2 = 65 TO 90
            ALPH$ = CHR$(a1) + CHR$(a2): ' PRINT a1; a2; ALPH$,: GOSUB 1000
            FOR I = 1 TO SKILL
                IF INT(skill(I)) <> rate GOTO 710
                IF ALPH$ <> LEFT$(SKILL$(I), 2) THEN GOTO 710
                IF skill(I) < .1 THEN skill(I) = -3 + JOT: GOTO 710

                SKILL$(I) = UCASE$(SKILL$(I)): 'PRINT skill$(i);: GOSUB 1000
                text$ = SKILL$(I) + STR$(INT(skill(I)) * -1): GOSUB 19999
                text$ = skillexp$(I): GOSUB 19999: PRINT #nnn,

                IF sample(I) = 0 THEN GOTO 710
                IF Animal = 1 THEN sample(I) = 1
                FOR J = 1 TO sample(I)
                    Difficulty$ = DIF$(I, J)
                    IF Difficulty$ = "SIM" THEN target = 2
                    IF Difficulty$ = "EAS" THEN target = 4
                    IF Difficulty$ = "ROU" THEN target = 6
                    IF Difficulty$ = "AVG" THEN target = 8
                    IF Difficulty$ = "DIF" THEN target = 10
                    IF Difficulty$ = "VDI" THEN target = 12
                    IF Difficulty$ = "FOR" THEN target = 14

                    TD$ = TD$(I, J)
                    TL$ = TL$(I, J)
                    time = VAL(LEFT$(TL$, 2))
                    ivl$ = RIGHT$(TL$, 1)
                    IF ivl$ = "S" THEN ivl$ = " Seconds"
                    IF ivl$ = "M" THEN ivl$ = " Minutes"
                    IF ivl$ = "H" THEN ivl$ = " Hours"
                    IF ivl$ = "D" THEN ivl$ = " Days"

                    char1$ = CHAR1$(I, J)
                    IF char1$ = "STR" THEN value = STRENGTH: GOSUB 800
                    IF char1$ = "DEX" THEN value = DEXTERITY: GOSUB 800
                    IF char1$ = "END" THEN value = ENDURANCE: GOSUB 800
                    IF char1$ = "INT" THEN value = INTELLIGENCE: GOSUB 800: IF Animal = 1 THEN modi = 0
                    IF char1$ = "EDU" THEN value = EDUCATION: GOSUB 800: IF Animal = 1 THEN modi = 0
                    IF char1$ = "SOC" THEN value = SOCIAL: GOSUB 800
                    char1 = modi
                    char2$ = CHAR2$(I, J)
                    IF char2$ = "STR" THEN value = STRENGTH: GOSUB 800
                    IF char2$ = "DEX" THEN value = DEXTERITY: GOSUB 800
                    IF char2$ = "END" THEN value = ENDURANCE: GOSUB 800
                    IF char2$ = "INT" THEN value = INTELLIGENCE: GOSUB 800: IF Animal = 1 THEN modi = 0
                    IF char2$ = "EDU" THEN value = EDUCATION: GOSUB 800: IF Animal = 1 THEN modi = 0
                    IF char2$ = "SOC" THEN value = SOCIAL: GOSUB 800
                    char2 = modi
                    charX = char1: IF char2 > charX THEN charX = char2
                    IF CT = 1 THEN charX = 0
                    modi = charX + INT(skill(I))
                    target = target - charX - INT(skill(I))
                    tx = target
                    IF tx > 12 THEN tx = 12
                    IF tx < 2 THEN tx = 2
                    percent = D62(tx)
                    IF Animal = 0 THEN text$ = DESC$(I, J): GOSUB 19999
                    PRINT #nnn, USING "##+"; target;
                    IF CT = 1 GOTO 30020
                    PRINT #nnn, " "; Difficulty$;
                    IF modi > 9 THEN PRINT #nnn, USING "+##"; modi; ELSE PRINT #nnn, USING "+#"; modi;

                    txx = target - 6 + 1: IF txx > 2 THEN PRINT #nnn, ", ExF<";: GOSUB 35000
                    txx = target - 2
                    IF txx < 3 GOTO 30021
                    IF txx > 2 THEN PRINT #nnn, USING ", AvF##"; target - 6 + 1;: PRINT #nnn, "-";: txx = target - 2: GOSUB 35000
                    30021
                    txx = target - 1: IF txx > 2 THEN PRINT #nnn, ", MaF=";: GOSUB 35000
                    txx = target: IF txx >= 2 THEN PRINT #nnn, ", MaS=";: GOSUB 35000
                    txx = target + 1 - 1

                    IF txx > 2 THEN PRINT #nnn, USING ", AvS##"; txx + 1;: PRINT #nnn, "-";: txx = target + 4: GOSUB 35000


                    txx = target + 6 - 1: IF txx >= 2 THEN PRINT #nnn, ", ExS>=";: GOSUB 35000

                    'PRINT #nnn, USING "###.#%"; percent;
                    'IF target + 6 < 12 THEN PRINT #nnn, USING ", Exceptional ##.#%"; D62(target + 6);

                    30020
                    PRINT #nnn, ", "; TD$ + "6 x" + STR$(time) + ivl$: PRINT #nnn,
                NEXT: PRINT #nnn,: PRINT #nnn,
            710 NEXT
        NEXT
    NEXT
NEXT
30030

CHOICE = 4: GOSUB 6000
nnn = 1
CHOICE = 5: GOSUB 6000


'GOSUB 1000
RUN
35000
'IF txx < 3 THEN PRINT #nnn, " ";: RETURN

GOTO 35010
IF txx > 13 THEN txx = 13
IF txx < 1 THEN txx = 1
percent = D62(txx)
PRINT #nnn, USING "###%"; percent;
RETURN
'IF txx > 13 THEN txx = 13
'IF txx < 1 THEN txx = 1
'percent = D62(txx)
35010

IF txx > 9 THEN PRINT #nnn, USING "##"; txx; ELSE PRINT #nnn, USING "#"; txx;

RETURN


36000

40000
'AAAAAAAAAAAAAAAAAAAA

DATA "admin"
DATA "This skill covers bureaucracies and administration of all sorts, including the navigation of bureaucratic obstacles or disasters. It also covers tracking inventories, ship manifests and other records."
DATA 2
DATA "AVG","1D","10S","EDU","EDU","Avoiding Close Examination of Papers"
DATA "Average (8+) Admin check (1D x 10 seconds, EDU or SOC)."

DATA "DIF","1D","10H","SOC","EDU","Dealing with Police Harassment"
DATA "Diffcult (10+) Admin check (1D x 10 minutes, EDU or SOC)"

DATA "administration"
DATA "This skill covers bureaucracies and administration of all sorts, including the navigation of bureaucratic obstacles or disasters. It also covers tracking inventories, ship manifests and other records."
DATA 2
DATA "AVG","1D","10S","EDU","EDU","Avoiding Close Examination of Papers"
DATA "Average (8+) Admin check (1D x 10 seconds, EDU or SOC)."

DATA "DIF","1D","10H","SOC","EDU","Dealing with Police Harassment"
DATA "Diffcult (10+) Admin check (1D x 10 minutes, EDU or SOC)"


DATA "advocate"
DATA "Advocate gives a knowledge of common legal codes and practises, especially interstellar law. It also gives experience in oratory, debate and public speaking, making it an excellent skill for lawyers and politicians."
DATA 2
DATA "AVG","1D","10S","EDU","EDU"," Arguing in Court: Opposed Advocate check"
DATA " (1D days, EDU or SOC)."
DATA "AVG","1D","10S","INT","INT","Debating an Argument: Opposed Advocate check"
DATA " (1D x 10 minutes, INT)"

DATA "airship"
DATA "Used for airships, dirigibles and other powered lighter than air craft."
DATA 2
DATA "ROU","1D","01M","DEX","DEX","Landing Safely"
DATA ": Routine (6+) Flyer check (1D minutes, DEX)."
DATA "AVG","1D","10M","DEX","DEX","Racing Another Flyer : Opposed Flyer check"
DATA ": Opposed Flyer check (1D x 10 minutes, DEX)."

'animals
'This skill, rare on industrialised or technologically
'advanced worlds, is for the care of animals.
'sPeCialities
DATA "animal (handling)"
DATA "Knowledge how to handle an animal and ride those trained to bear a rider. Unusual animals raise the diffculty of the check."
DATA 1
DATA "DIF","1D","01S","DEX","DEX","Riding a Horse into Battle. If successful, control the horse for a number of minutes equal to the Effect before needing to make another check."
DATA ": Diffcult (10+) Animals (handling) check (1D seconds, DEX). "

DATA "Animal (Training)"
DATA "Knowledge how to tame and train animals."
DATA 1
DATA "FOR","1D","01D","INT","INT","Taming a Strange Alien Creature"
DATA ": Formidable (14+) Animals (training) check (1D days, INT)."

DATA "Animal (veterinary)"
DATA "Training in veterinary medicine and animal care."
DATA 1
DATA "AVG","1D","01M","EDU","EDU","Applying Medical Care. The animal regains lost characteristic points equal to the Effect."
DATA ": Average (8+) Medic check (1D minutes, EDU)."

DATA "astrogation"
DATA "This skill is for plotting the courses of starships and calculating accurate jumps."
DATA 2
DATA "DIF","1D","10M","EDU","EDU","Plotting Course to a Target World Using a Gas Giant for a Gravity Slingshot."
DATA "Diffcult (10+) Astrogation check (1D x 10 minutes, EDU)."

DATA "EAS","1D","10M","EDU","EDU","Plotting a Standard Jump, with DM- equal to the Jump distance."
DATA "Easy (4+) Astrogation check (1D x 10 minutes, EDU)"



DATA "Art (Performer)"
DATA "Trained actor, dancer or singer at home on the stage, screen or holo."
DATA 2
DATA "AVG","1D","01H","EDU","EDU","Performing a Play"
DATA ": Average (8+) Art (performer) check (1D hours, EDU)"

DATA "AVG","1D","01M","INT","INT","Convincing a Person you are Actually Someone Else, opposed Recon check"
DATA ":Art (performer) check (INT) opposed by Recon check (INT)."

DATA "Art (holography)"
DATA "Recording and producing aesthetically pleasing and clear holographic images."
DATA 1
DATA "FOR","1D","01S","DEX","DEX","Surreptitiously Switching on Your Recorder While in a Secret Meeting"
DATA ": Formidable (14+) Art (holography) check (1D seconds, DEX)."

DATA "Art (instrument)"
DATA "Playing a particular musical instrument, such as flute, piano or organ."
DATA 1
DATA "DIF","1D","10M","EDU","EDU","Playing a Concerto"
DATA ": Diffcult (10+) Art (instrument) check (1D x 10 minutes, EDU)."

DATA "Art (visual Media)"
DATA "Making artistic or abstract paintings or sculptures in a variety of media."
DATA 1
DATA "DIF","1D","01D","INT","INT","Making a Statue of Someone"
DATA ": Diffcult (10+) Art (visual media) check (1D days, INT)."

DATA "Art (Write)"
DATA "Composing inspiring or interesting pieces of text."
DATA 1
DATA "DIF","1D","01H","INT","EDU","Rousing the People of a Planet by Exposing Their Government's Corruption"
DATA ": Diffcult (10+) Art (write) check (1D hours, INT or EDU)."

'DATA "Writing the New Edition of Traveller
'DATA ": Formidable (14+) Art (write) check (1D months, INT).



'athletics
'The Traveller is a trained athlete and is physically ft. The Athletics skill effectively augments a Traveller's
'physical characteristics; whatever you can do with Strength alone you can also add your Athletics (strength)
'DM to, for example. Athletics is also the principal skill used in adverse gravitational environments, specifcally
'Athletics (dexterity) in low or zero-G, and Athletics (strength) in high-G locations.

'sPeCialities

DATA "Dexterity"
DATA "Climbing, Juggling, Throwing. For alien races with wings, this also includes flying."
DATA 5
DATA "AVG","1D","10S","DEX","DEX","Climbing. Usually irrelevant unless trying to do something while climbing, in which case the climbing is part of a task chain or multiple action."
DATA ": Diffculty varies. Athletics (dexterity) check (1D x 10 seconds, DEX). "

DATA "AVG","1D","01S","DEX","DEX","Sprinting. If sprinting flat out, cover 24 + Effect metres with every check. Avoiding obstacles while sprinting requires another Athletics (dexterity) check (Diffcult, because of multiple actions)."
DATA ": Average (8+) Athletics (dexterity) check (1D seconds, DEX). "

DATA "AVG","1D","01S","DEX","DEX","High Jumping. A number of metres straight up equal to the Effect halved."
DATA "Average (8+) Athletics (dexterity) check (1D seconds, DEX)."

DATA "AVG","1D","01S","DEX","DEX","Long Jumping. Jumping a number of metres forward equal to the Effect with a running start."
DATA ": Average (8+) Athletics (dexterity) check (1D seconds, DEX)."

DATA "AVG","1D","01S","DEX","DEX","Righting Yourself When Artifcial Gravity Suddenly Fails on Board a Ship."
DATA ": Average (8+) Athletics (dexterity) check (1D seconds, DEX)."

DATA "endurance"
DATA "Long-distance running, hiking, long distance swimming."
DATA 2
DATA "AVG","1D","10M","END","END","Long-distance running, hiking."
DATA ": Average (8+) Athletics (endurance) check (1D x 10 minutes, END)."
DATA "AVG","1D","10M","END","END","Long-distance Swimming."
DATA ": Average (8+) Athletics (endurance) check (1D x 10 minutes, END)."

DATA "strength"
DATA "Feats of strength, weight-lifting."
DATA 3
DATA "AVG","1D","01M","STR","STR","Arm Wrestling"
DATA ": Opposed Athletics (strength) check (1D minutes, STR)."
DATA "AVG","1D","10S","STR","STR","Feats of Strength"
DATA ": Average (8+) Athletics (strength) check (1D x 10 seconds, STR)."
DATA "DIF","1D","01S","STR","STR","Performing a Complicated Task in a High Gravity Environment"
DATA ": Diffcult (10+) Athletics (strength) check (1D seconds, STR)."

DATA "Zero-G"
DATA "Using a ranged weapon that does not have the Zero-G trait or any close combat weapon, make a Zero-G check."
DATA 2
DATA "AVG","1D","01S","DEX","DEX","Check to not only automatically miss his target but start to spin helplessly out of control."
DATA ": Athletics (Zero-G) check (1D minutes, DEX)."
DATA "AVG","2D","01S","DEX","DEX","Regain control in Zero-G"
DATA ": Average (8+) Athletics (Dexterity) check (2D x 10 seconds, DEX)."


'BBBBBBBBBBBBBBBBBBBBBBB


DATA "Blade-Cbt"
DATA "Attacking with swords, rapiers, blades and other edged weapons."
DATA 1
DATA "AVG","1D","01S","STR","DEX","Attacking with a Sword."
DATA ": Average (8+) Melee (blade) check (1D seconds, STR or DEX)."




DATA "Blade"
DATA "Blade combat is a specific military skill in the use of edged weapons in combat."
DATA 1
DATA "AVG","1D","01S","STR","DEX","Attacking with a Blade."
DATA ": Average (8+) Melee (blade) check (1D seconds, STR or DEX)."

DATA "Blade-Combat"
DATA "Blade combat is a specific military skill in the use of edged weapons in combat."
DATA 1
DATA "AVG","1D","01S","STR","DEX","Attacking with a Blade."
DATA ": Average (8+) Melee (blade) check (1D seconds, STR or DEX)."

DATA "Blade Combat"
DATA "Blade combat is a specific military skill in the use of edged weapons in combat."
DATA 1
DATA "AVG","1D","01S","STR","DEX","Attacking with a Blade."
DATA ": Average (8+) Melee (blade) check (1D seconds, STR or DEX)."



DATA "Dagger"
DATA "Attacking with a Dagger."
DATA 1
DATA "AVG","1D","01S","DEX","DEX","Thrusting a Dagger."
DATA ": Average (8+) Melee (blade) check (1D seconds, STR or DEX)."

DATA "Foil"
DATA "Fencing with a Foil."
DATA 1
DATA "AVG","1D","01S","DEX","DEX","Thrusting a Foil."
DATA ": Average (8+) Melee (blade) check (1D seconds, STR or DEX)."

DATA "Sword"
DATA "Attacking with a one handed blade weapon."
DATA 1
DATA "AVG","1D","01S","DEX","DEX","Thrusting a Dagger."
DATA ": Average (8+) Melee (blade) check (1D seconds, STR or DEX)."

DATA "Cutlass"
DATA "Attacking with a one handed long weapon."
DATA 1
DATA "AVG","1D","01S","STR","DEX","Slashing with a Cutlass."
DATA ": Average (8+) Melee (blade) check (1D seconds, STR or DEX)."

DATA "Broadsword"
DATA "Attacking with a one handed long weapon."
DATA 1
DATA "AVG","1D","01S","STR","DEX","Slashing with a Broadsword."
DATA ": Average (8+) Melee (blade) check (1D seconds, STR or DEX)."

DATA "Bayonet"
DATA "Attacking with a two handed long weapon."
DATA 1
DATA "AVG","1D","01S","STR","STR","Thrusting with a Bayonet."
DATA ": Average (8+) Melee (blade) check (1D seconds, STR or DEX)."

DATA "Spear"
DATA "Attacking with a two handed long weapon."
DATA 1
DATA "AVG","1D","01S","STR","STR","Thrusting with a Spear."
DATA ": Average (8+) Melee (blade) check (1D seconds, STR or DEX)."

DATA "Halberd"
DATA "Attacking with a two handed long weapon."
DATA 1
DATA "AVG","1D","01S","STR","STR","Attacking with with a Halberd."
DATA ": Average (8+) Melee (blade) check (1D seconds, STR or DEX)."

DATA "Pike"
DATA "Attacking with a two handed long weapon."
DATA 1
DATA "AVG","1D","01S","STR","END","Thrusting with a Pike."
DATA ": Average (8+) Melee (blade) check (1D seconds, STR or DEX)."

DATA "Cudgel"
DATA "Attacking with a blunt weapon."
DATA 1
DATA "AVG","1D","01S","STR","STR","Smashing with a cudgel."
DATA ": Average (8+) Melee (blade) check (1D seconds, STR or DEX)."

DATA "broker"
DATA "The Broker skill allows to negotiate trades and arrange fair deals. It is heavily used when trading (see the Trade chapter)."
DATA 2
DATA "AVG","1D","01H","INT","INT","Negotiating a Deal"
DATA ": Average (8+) Broker check (1D hours, INT)."
DATA "AVG","1D","01H","SOC","SOC","Finding a Buyer"
DATA ": Average (8+) Broker check (1D hours, SOC)."

DATA "trade"
DATA "The Broker skill allows to negotiate trades and arrange fair deals. It is heavily used when trading (see the Trade chapter)."
DATA 2
DATA "AVG","1D","01H","INT","INT","Negotiating a Deal"
DATA ": Average (8+) Broker check (1D hours, INT)."
DATA "AVG","1D","01H","SOC","SOC","Finding a Buyer"
DATA ": Average (8+) Broker check (1D hours, SOC)."


'CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC

DATA "Carouse"
DATA "Carousing is the art of socialising; having fun, but also ensuring other people have fun, and infectious good humour. It also covers social awareness and subterfuge in such situations."
DATA 2
DATA "AVG","1D","01H","END","END","Drinking Someone Under the Table : Opposed Carouse check"
DATA "(1D hours, END). Diffculty varies by liquor."
DATA "AVG","1D","01H","SOC","SOC","Gathering Rumours at a Party"
DATA ": Average (8+) Carouse check (1D hours, SOC)."

DATA "Carousing"
DATA "Carousing is the art of socialising; having fun, but also ensuring other people have fun, and infectious good humour. It also covers social awareness and subterfuge in such situations."
DATA 2
DATA "AVG","1D","01H","END","END","Drinking Someone Under the Table : Opposed Carouse check"
DATA "(1D hours, END). Diffculty varies by liquor."
DATA "AVG","1D","01H","SOC","SOC","Gathering Rumours at a Party"
DATA ": Average (8+) Carouse check (1D hours, SOC)."


DATA "Comms"
DATA "The use of modern telecommunications; opening communications channels, querying computer networks, jamming signals and so on, as well as the proper protocols for communicating with starports and other spacecraft."
DATA 6
DATA "ROU","1D","01M","EDU","EDU","Requesting Landing Privileges at a Starport"
DATA ": Routine (6+) Electronic (comms) check (1D minutes, EDU)."

DATA "AVG","1D","10M","EDU","EDU","Accessing Publicly Available but Obscure Data Over Comms"
DATA ": Average (8+) Electronic (comms) check (1D x 10 minutes, EDU)."

DATA "DIF","1D","10M","INT","INT","Bouncing a Signal off Orbiting Satellite to Hide Your Transmitter"
DATA ": Diffcult (10+) Electronics (comms) check (1D x 10 minutes, INT)."

DATA "DIF","1D","01M","INT","INT","Jamming a Radio System: DM TL-Difference. Opposed Electronics (comms) check"
DATA "Using a comm system with a higher Technology Level than the opponent gains DM+1 for every TL of difference."

DATA "VDI","1D","01M","INT","INT","Jamming a Laser System: DM TL-Difference. Opposed Electronics (comms) check"
DATA " (1D minutes, INT). Diffcult (10+) for radio, Very Diffcult (12+) for laser"

DATA "FOR","1D","01M","INT","INT","Jamming a Maser System: DM TL-Difference. Opposed Electronics (comms) check"
DATA " (1D minutes, INT). Diffcult (10+) for radio, Very Diffcult (12+) for laser"




'DDDDDDDDDDDDDDDDD

DATA "Deception"
DATA "Deception allows to lie fluently, disguise, perform sleight of hand and fool onlookers. Most underhanded ways of cheating and lying fall under deception."
DATA 3
DATA "VDI","1D","01M","INT","INT","Convincing a Guard to let you Past Without ID"
DATA ": Very Diffcult (12+) Deception check (1D minutes, INT). Alternatively, oppose with a Recon check."
DATA "AVG","1D","01H","DEX","DEX","Palming a Credit Chit"
DATA ": Average (8+) Deception check (1D seconds, DEX)."
DATA "DIF","1D","01M","INT","SOC","Disguising Yourself as a Wealthy Noble to Fool a Client"
DATA ":Diffcult (10+) Deception check (1D x 10 minutes, INT or SOC). Alternatively, oppose with a Recon check."

DATA "Diplomat"
DATA "The Diplomat skill is for negotiating deals, establishing peaceful contact and smoothing over social faux pas. It includes how to behave in high society and proper ways to address nobles. It is a much more formal skill than Persuade."
DATA 3
DATA "DIF","1D","01M","SOC","SOC","Greeting the Emperor Properly"
DATA ": Diffcult (10+) Diplomat check (1D minutes, SOC)."
DATA "AVG","1D","01D","EDU","EDU","Negotiating a Peace Treaty"
DATA ": Average (8+) Diplomat check (1D days, EDU)."
DATA "AVG","1D","10S","INT","INT","Transmitting a Formal Surrender"
DATA ": Average (8+) Diplomat check (1D x 10 seconds, INT)."

DATA "ATV"
DATA "The individual is acquainted with modern all terrain vehicles, and has been trained in, or has experience with, their operation. The term ATV (all terrain vehicle) includes AFV (armored fighting vehicle) and covers both wheeled and tracked vehicles."
DATA 3
DATA "DIF","1D","01M","DEX","DEX","Manoeuvring (or Smashing, Depending on the Vehicle) Through a Forest"
DATA ": Diffcult (10+) Drive (tracked) check (1D minutes, DEX)."
DATA "AVG","1D","01S","DEX","DEX","Driving a Tank into a Cargo Bay"
DATA ": Average (8+) Drive (tracked) check (1D x 10 seconds, DEX)."
DATA "AVG","1D","01S","DEX","DEX","Avoiding an Unexpected Obstacle on the Road"
DATA "Average (8+) Drive (wheeled) check (1D seconds, DEX)."


DATA "Drive (Hovercraft)"
DATA "Vehicles that rely on a cushion of air and thrusters for motion."
DATA 1
DATA "DIF","1D","01M","DEX","DEX","Manoeuvring a Hovercraft Through a Tight Canal:"
DATA "Diffcult (10+) Drive (hovercraft) check (1D minutes, DEX)."

DATA "Hovercraft"
DATA "Vehicles that rely on a cushion of air and thrusters for motion."
DATA 1
DATA "DIF","1D","01M","DEX","DEX","Manoeuvring a Hovercraft Through a Tight Canal:"
DATA "Diffcult (10+) Drive (hovercraft) check (1D minutes, DEX)."


DATA "Drive (Mole)"
DATA "For controlling vehicles that move through solid matter using drills or other earth-moving technologies, such as plasma torches or cavitation."
DATA 2
DATA "AVG","1D","10M","INT","INT","Surfacing in the Right Place"
DATA ": Average (8+) Drive (mole) check (1D x 10 minutes, INT)."
DATA "DIF","1D","10M","DEX","DEX",Precisely Controlling a Dig to Expose a Vein of Minerals
DATA ": Diffcult (10+) Drive (mole) check (1D x 10 minutes, DEX)."


DATA "Drive (Track)"
DATA "For tanks and other vehicles that move on tracks."
DATA 2
DATA "DIF","1D","01M","DEX","DEX","Manoeuvring (or Smashing, Depending on the Vehicle) Through a Forest"
DATA ": Diffcult (10+) Drive (tracked) check (1D minutes, DEX)."
DATA "AVG","1D","01S","DEX","DEX","Driving a Tank into a Cargo Bay"
DATA ": Average (8+) Drive (tracked) check (1D x 10 seconds, DEX)."

DATA "Drive (Walker)"
DATA "Vehicles that use two or more legs to manoeuvre."
DATA 1
DATA "DIF","1D","01M","DEX","DEX",Negotiating Rough Terrain
DATA ": Diffcult (10+) Drive (walker) check (1D minutes, DEX)."

DATA "Drive (Wheel)"
DATA "For automobiles and similar groundcars."
DATA 3
DATA "AVG","1D","01M","DEX","DEX","Driving a Groundcar in a short Race: Opposed Drive"
DATA "(wheeled) check (1D minutes, DEX)"
DATA "AVG","1D","01H","END","END","Driving a Groundcar in a Long Race: Opposed Drive"
DATA "(wheeled) check (1D minutes, END)"
DATA "AVG","1D","01S","DEX","DEX","Avoiding an Unexpected Obstacle on the Road"
DATA "Average (8+) Drive (wheeled) check (1D seconds, DEX)."


'EEEEEEEEEEEEEEEEEEEEE
DATA "Electronics"
DATA "The individual has skill in the use, operation, and repair of electronic devices. The person is considered handy in this field, with the equivalent of a green thumb; this skill includes the repair of energy weapons."
DATA 4
DATA "ROU","1D","10M","INT","EDU","Making a Detailed Sensor Scan"
DATA ": Routine (6+) Electronics (sensors) check (1D x 10 minutes, INT or EDU)."

DATA "AVG","1D","01H","INT","INT","Analysing Sensor Data"
DATA ": Average (8+) Electronics (sensors) check (1D hours, INT)."

DATA "ROU","1D","01H","DEX","DEX","Using a Mining Drone to Excavate an Asteroid"
DATA ": Routine (6+) Electronics (remote ops) check (1D hours, DEX)."

DATA "DIF","1D","10M","INT","INT","Bouncing a Signal off Orbiting Satellite to Hide Your Transmitter"
DATA ": Diffcult (10+) Electronics (comms) check (1D x 10 minutes, INT)."

DATA "Electronic"
DATA "The individual has skill in the use, operation, and repair of electronic devices. The person is considered handy in this field, with the equivalent of a green thumb; this skill includes the repair of energy weapons."
DATA 4
DATA "ROU","1D","10M","INT","EDU","Making a Detailed Sensor Scan"
DATA ": Routine (6+) Electronics (sensors) check (1D x 10 minutes, INT or EDU)."

DATA "AVG","1D","01H","INT","INT","Analysing Sensor Data"
DATA ": Average (8+) Electronics (sensors) check (1D hours, INT)."

DATA "ROU","1D","01H","DEX","DEX","Using a Mining Drone to Excavate an Asteroid"
DATA ": Routine (6+) Electronics (remote ops) check (1D hours, DEX)."

DATA "DIF","1D","10M","INT","INT","Bouncing a Signal off Orbiting Satellite to Hide Your Transmitter"
DATA ": Diffcult (10+) Electronics (comms) check (1D x 10 minutes, INT)."


DATA "Electronics (Comms)"
DATA "The use of modern telecommunications; opening communications channels, querying computer networks, jamming signals and so on, as well as the proper protocols for communicating with starports and other spacecraft."
DATA 6
DATA "ROU","1D","01M","EDU","EDU","Requesting Landing Privileges at a Starport"
DATA ": Routine (6+) Electronic (comms) check (1D minutes, EDU)."

DATA "AVG","1D","10M","EDU","EDU","Accessing Publicly Available but Obscure Data Over Comms"
DATA ": Average (8+) Electronic (comms) check (1D x 10 minutes, EDU)."

DATA "DIF","1D","10M","INT","INT","Bouncing a Signal off Orbiting Satellite to Hide Your Transmitter"
DATA ": Diffcult (10+) Electronics (comms) check (1D x 10 minutes, INT)."

DATA "DIF","1D","01M","INT","INT","Jamming a Radio System: DM TL-Difference. Opposed Electronics (comms) check"
DATA "Using a comm system with a higher Technology Level than the opponent gains DM+1 for every TL of difference."

DATA "VDI","1D","01M","INT","INT","Jamming a Laser System: DM TL-Difference. Opposed Electronics (comms) check"
DATA " (1D minutes, INT). Diffcult (10+) for radio, Very Diffcult (12+) for laser"

DATA "FOR","1D","01M","INT","INT","Jamming a Maser System: DM TL-Difference. Opposed Electronics (comms) check"
DATA " (1D minutes, INT). Diffcult (10+) for radio, Very Diffcult (12+) for laser"

DATA "Electronics (Computers)"
DATA "Using and controlling computer systems, and similar electronics and electrics."
DATA 4
DATA "EAS","1D","10S","INT","EDU","Accessing Publicly Available Data"
DATA ": Easy (4+) Electronics (computers) check (1D minutes, INT or EDU)."

DATA "ROU","1D","10S","INT","EDU","Activating a Computer Program on a Ship's Computer"
DATA ": Routine (6+) Electronics (computers) check (1D x 10 seconds, INT or EDU)."

DATA "DIF","1D","01H","INT","INT","Searching a Corporate Database for Evidence of Illegal Activity"
DATA ": Diffcult (10+) Electronics (computers) check (1D hours, INT)."

DATA "FOR","1D","10H","INT","INT","Hacking into a Secure Computer Network"
DATA ": Formidable (14+) Electronics (computers) check (1D x 10 hours, INT)."
'DATA "Hacking is aided by Intrusion programs and made more diffcult by Security programs. The Effect determines the amount of data retrieved; failure means the targeted system may be able to trace the hacking attempt.

DATA "Computer"
DATA "Using and controlling computer systems, and similar electronics and electrics."
DATA 4
DATA "EAS","1D","10S","INT","EDU","Accessing Publicly Available Data"
DATA ": Easy (4+) Electronics (computers) check (1D minutes, INT or EDU)."

DATA "ROU","1D","10S","INT","EDU","Activating a Computer Program on a Ship's Computer"
DATA ": Routine (6+) Electronics (computers) check (1D x 10 seconds, INT or EDU)."

DATA "DIF","1D","01H","INT","INT","Searching a Corporate Database for Evidence of Illegal Activity"
DATA ": Diffcult (10+) Electronics (computers) check (1D hours, INT)."

DATA "FOR","1D","10H","INT","INT","Hacking into a Secure Computer Network"
DATA ": Formidable (14+) Electronics (computers) check (1D x 10 hours, INT)."
'DATA "Hacking is aided by Intrusion programs and made more diffcult by Security programs. The Effect determines the amount of data retrieved; failure means the targeted system may be able to trace the hacking attempt.



DATA "Electronic (Remote Ops)"
DATA "Using telepresence to remotely control drones, missiles, robots and other devices."
DATA 1
DATA "ROU","1D","01H","DEX","DEX","Using a Mining Drone to Excavate an Asteroid"
DATA ": Routine (6+) Electronics (remote ops) check (1D hours, DEX)."

DATA "Electronic (Sensors)"
DATA "The use and interpretation of data from electronic sensor devices, from observation satellites and remote probes to thermal imaging and densitometers."
DATA 2
DATA "ROU","1D","10M","INT","EDU","Making a Detailed Sensor Scan"
DATA ": Routine (6+) Electronics (sensors) check (1D x 10 minutes, INT or EDU)."

DATA "AVG","1D","01H","INT","INT","Analysing Sensor Data"
DATA ": Average (8+) Electronics (sensors) check (1D hours, INT)."

DATA "engineer"
DATA "The individual is skilled in the operation and maintenance of starship maneuver drives, jump drives, and power plants. Engineering experience enables an individual to operate the vital drives of starships (and interplanetary craft) and to maintain the machinery against failure."
DATA 3
DATA "AVG","1D","10S","INT","INT","Estimating a Ship's Tonnage From its Observed Performance"
DATA ": Average (8+) Engineer (m-drive) check (1D x 10 seconds, INT)."

DATA "EAS","1D","10M","EDU","EDU","Making a Jump"
DATA ": Easy (4+) Engineer (j-drive) check (1D x 10 minutes, EDU)."

DATA "DIF","1D","01M","INT","INT","Monitoring an Enemy ship's Power Output to Determine its Capabilities"
DATA ": Diffcult (10+) Engineer (power) check (1D minutes, INT)."


'The Engineer skill is used to operate and maintain
'spacecraft and advanced vehicles. Engineer can be used
'to make repairs on damaged systems on spacecraft and
'advanced vehicles. For repairs on simpler machines and
'systems, use the Mechanic skill.
'sPeCialities

DATA "Engineer (M-drive)"
DATA "Maintaining and operating a spacecraft's manoeuvre drive, as well as its artifcial gravity. Overcharging a Thruster Plate to Increase a Ship's"
DATA 1
DATA "AVG","1D","10S","INT","INT","Estimating a Ship's Tonnage From its Observed Performance"
DATA ": Average (8+) Engineer (m-drive) check (1D x 10 seconds, INT)."

DATA "Engeneering (J-drive)"
DATA "Maintaining and operating a spacecraft's Jump drive."
DATA 1
DATA "EAS","1D","10M","EDU","EDU","Making a Jump"
DATA ": Easy (4+) Engineer (j-drive) check (1D x 10 minutes, EDU)."

DATA "Engineering (Life support)"
DATA "Covers oxygen generators, heating and lighting and other necessary life support systems."
DATA 1
DATA "AVG","1D","01M","EDU","EDU","Safely Reducing Power to Life Support to Prolong a Ship's Battery Life"
DATA ": Average (8+) Engineer (life support) check (1D minutes, EDU)."

DATA "Engineering (Power)"
DATA "Maintaining and operating a spacecraft's power plant."
DATA 1
DATA "DIF","1D","01M","INT","INT","Monitoring an Enemy ship's Power Output to Determine its Capabilities"
DATA ": Diffcult (10+) Engineer (power) check (1D minutes, INT)."





DATA "explosives"
DATA "The Explosives skill covers the use of demolition charges and other explosive devices, including assembling or disarming bombs. A failed Explosives check with an Effect of -4 or less can result in a bomb detonating prematurely."
DATA 3
DATA "AVG","1D","10M","EDU","EDU","Planting Charges to Collapse a Wall in a Building"
DATA ": Average (8+) Explosives check (1D x 10 minutes, EDU)."

DATA "AVG","1D","10S","EDU","EDU","Planting a Breaching Charge"
DATA ": Average (8+) Explosives check (1D x 10 seconds, EDU). The damage from the explosive is multiplied by the Effect."

DATA "FOR","1D","01M","DEX","DEX","Disarming a Bomb Equipped with Anti-Tamper Trembler Detonators"
DATA ": Formidable (14+) Explosives check (1D minutes, DEX)."

DATA "Demolitions"
DATA "The Demolitions skill covers the use of demolition charges and other explosive devices, including assembling or disarming bombs. A failed Explosives check with an Effect of -4 or less can result in a bomb detonating prematurely."
DATA 3
DATA "AVG","1D","10M","EDU","EDU","Planting Charges to Collapse a Wall in a Building"
DATA ": Average (8+) Explosives check (1D x 10 minutes, EDU)."

DATA "AVG","1D","10S","EDU","EDU","Planting a Breaching Charge"
DATA ": Average (8+) Explosives check (1D x 10 seconds, EDU). The damage from the explosive is multiplied by the Effect."

DATA "FOR","1D","01M","DEX","DEX","Disarming a Bomb Equipped with Anti-Tamper Trembler Detonators"
DATA ": Formidable (14+) Explosives check (1D minutes, DEX)."



'FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF

'Forward Observers
'On the battlefelds of the far future, immense and powerful weapons can be deployed against the enemy.
'However, whether they be missiles or bombs from fast-?ying aircraft, massive shells from artillery
'or apocalyptic energy blasts from orbiting spacecraft, they all still need eyes on the ground to
'be delivered accurately and effectively. This is where forward observers come in.

'A forward observer is anyone who has a direct line of sight to a target and a communications link
'to a weapon delivery 'system capable of attacking the target but otherwise unable to make the attack
'due to being beyond line of sight (for Artillery weapons), travelling too fast (aircraft) or simply
'being too far away to gain accurate visual sight (spacecraft in orbit).

'The forward observer makes an Electronics (comms) check (1D rounds, INT). Additional modifers may
'be included as if this Electronics (comms) check was an attack roll, including those for battlefeld
'conditions, cover, and any other factors the referee feels relevant.

'This check is then used as the start of a task chain, to be followed by a straight attack roll by
'the aircraft, artillery or orbiting spacecraft. The only modifers applied to this attack
'roll are from the task chain and the skill of the attacker using the weapon.

'If the attack roll misses the target, roll a dice for each point of negative Effect, then multiply
'the total by 10 if the attack was from aircraft or artillery and 100 if it were from a spacecraft.
'This is the number of metres the attack misses by. The referee can randomly determine in which
'direction the attack actually lands.

DATA "Forward Observer"
DATA "The use of modern telecommunications to transmit the position of an enemy and guide incoming munitions to the target."
DATA 1
DATA "ROU","1D","01M","INT","INT","Requesting Landing Privileges at a Starport"
DATA ": Routine (6+) Electronic (comms) check (1D minutes, EDU)."

'flyer
'The various specialities of this skill cover
'different types of flying vehicles. Flyers
'only work in an atmosphere; vehicles that
'can leave the atmosphere and enter orbit
'generally use the Pilot skill.
'sPeCialities

DATA "flyer (airship)"
DATA "Used for airships, dirigibles and other powered lighter than air craft."
DATA 2
DATA "ROU","1D","01M","DEX","DEX","Landing Safely"
DATA ": Routine (6+) Flyer check (1D minutes, DEX)."
DATA "AVG","1D","10M","DEX","DEX","Racing Another Flyer : Opposed Flyer check"
DATA ": Opposed Flyer check (1D x 10 minutes, DEX)."

DATA "flyer (grav)"
DATA "This covers air/rafts, grav belts and other vehicles that use gravitic technology."
DATA 2
DATA "ROU","1D","01M","DEX","DEX","Landing Safely"
DATA ": Routine (6+) Flyer check (1D minutes, DEX)."
DATA "AVG","1D","10M","DEX","DEX","Racing Another Flyer : Opposed Flyer check"
DATA ": Opposed Flyer check (1D x 10 minutes, DEX)."

DATA "flyer (ornithopter)"
DATA "For vehicles that fly through the use of flapping wings."
DATA 2
DATA "ROU","1D","01M","DEX","DEX","Landing Safely"
DATA ": Routine (6+) Flyer check (1D minutes, DEX)."
DATA "AVG","1D","10M","DEX","DEX","Racing Another Flyer : Opposed Flyer check"
DATA ": Opposed Flyer check (1D x 10 minutes, DEX)."

DATA "flyer (rotor)"
DATA "For helicopters, tilt-rotors and aerodynes."
DATA 2
DATA "ROU","1D","01M","DEX","DEX","Landing Safely"
DATA ": Routine (6+) Flyer check (1D minutes, DEX)."
DATA "AVG","1D","10M","DEX","DEX","Racing Another Flyer : Opposed Flyer check"
DATA ": Opposed Flyer check (1D x 10 minutes, DEX)."

DATA "flyer (Wing)"
DATA "For jets, vectored thrust aircraft and aeroplanes using a lifting body."
DATA 2
DATA "ROU","1D","01M","DEX","DEX","Landing Safely"
DATA ": Routine (6+) Flyer check (1D minutes, DEX)."
DATA "AVG","1D","10M","DEX","DEX","Racing Another Flyer : Opposed Flyer check"
DATA ": Opposed Flyer check (1D x 10 minutes, DEX)."



DATA "Forgery"
DATA "The individual has a skill at Documents necessary for cargo transfers, faking documents and papers with a view t o bank transactions, personal identification, and deceiving officials, banks, patrons, or other many other purposes are often closely inpersons. spected by officials such as the police, customs agents, or clerks when encounters occur (such encounters happen when the law level for a world or less is thrown; generally once or twice per day). The throw for detection of forged or fake documents is 6+; DMs to be applied: -2per level of expertise."
DATA 4
DATA "AVG","1D","01H","DEX","INT","Forging documentation generated at a TL below 7."
DATA ":"
DATA "DIF","1D","01H","DEX","EDU","Forging documentation generated at TL 7-9."
DATA ":"
DATA "VDI","1D","01H","INT","EDU","Forging documentation generated at TL 10-12."
DATA ":"
DATA "FOR","1D","01H","INT","EDU","Forging documentation generated at TL 13+."
DATA ":"







'GGGGGGGGGGGGGGGGGGGGGGGGGGGGGGG

DATA "gambling"
DATA "Familiarity with a wide variety of gambling games, such as poker, roulette, blackjack, horse-racing, sports betting and so on, and has an excellent grasp of statistics and probability. Gambler increases the rewards from Benefit Rolls, giving DM+1 to the cash roll if Gambler skill is 1 or better."
DATA 2
DATA "AVG","1D","01H","INT","INT","A Casual Game of Poker: Opposed Gambler check"
DATA "(1D hours, INT)."

DATA "AVG","1D","01M","INT","INT","Picking the Right Horse to Bet On"
DATA ": Average (8+) Gambler check (1D minutes, INT)"

DATA "gambler"
DATA "Familiarity with a wide variety of gambling games, such as poker, roulette, blackjack, horse-racing, sports betting and so on, and has an excellent grasp of statistics and probability. Gambler increases the rewards from Benefit Rolls, giving DM+1 to the cash roll if Gambler skill is 1 or better."
DATA 2
DATA "AVG","1D","01H","INT","INT","A Casual Game of Poker: Opposed Gambler check"
DATA "(1D hours, INT)."

DATA "AVG","1D","01M","INT","INT","Picking the Right Horse to Bet On"
DATA ": Average (8+) Gambler check (1D minutes, INT)"


DATA "grav"
DATA "This covers air/rafts, grav belts and other vehicles that use gravitic technology."
DATA 2
DATA "ROU","1D","01M","DEX","DEX","Landing Safely"
DATA ": Routine (6+) Flyer check (1D minutes, DEX)."
DATA "AVG","1D","10M","DEX","DEX","Racing Another Flyer : Opposed Flyer check"
DATA ": Opposed Flyer check (1D x 10 minutes, DEX)."

DATA "Air/Raft"
DATA "This covers air/rafts, grav belts and other vehicles that use gravitic technology."
DATA 2
DATA "ROU","1D","01M","DEX","DEX","Landing Safely"
DATA ": Routine (6+) Flyer check (1D minutes, DEX)."
DATA "AVG","1D","10M","DEX","DEX","Racing Another Flyer : Opposed Flyer check"
DATA ": Opposed Flyer check (1D x 10 minutes, DEX)."




'gunner
'The various specialities of this skill deal with the operation
'of ship-mounted weapons in space combat. See Spacecraft
'Operations chapter for more details. Most Travellers have
'smaller ships equipped solely with turret weapons.
'sPeCialities

DATA "Gunnery"
DATA "Operating turret-mounted weapons on board a ship."
DATA 1
DATA "AVG","1D","01S","DEX","DEX","Firing a Turret at an Enemy Ship"
DATA ": Average (8+) Gunner (turret) check (1D seconds, DEX)."


DATA "Gunner (Turret)"
DATA "Operating turret-mounted weapons on board a ship."
DATA 1
DATA "AVG","1D","01S","DEX","DEX","Firing a Turret at an Enemy Ship"
DATA ": Average (8+) Gunner (turret) check (1D seconds, DEX)."

DATA "Gunner (Ortillery)"
DATA ": A contraction of Orbital Artillery - using a ship's weapons for planetary bombardment or attacks on stationary targets."
DATA 1
DATA "AVG","1D","01M","INT","INT","Firing Ortillery"
DATA ": Average (8+) Gunner (ortillery) check (1D minutes, INT)."

DATA "Gunner (Screen)"
DATA "Activating and using a ship's energy screens like Black Globe generators or meson screens."
DATA 1
DATA "DIF","1D","01S","DEX","DEX","Activating a Screen to Intercept Enemy Fire"
DATA ": Diffcult (10+) Gunner (screen) check (1D seconds, DEX)."

DATA "Gunner (Capital)"
DATA "Operating bay or spinal mount weapons on board a ship."
DATA 1
DATA "AVG","1D","01M","INT","INT","Firing a Spinal Mount Weapon"
DATA ": Average (8+) Gunner (capital) check (1D minutes, INT)"

DATA "Gun Combat (Archaic)"
DATA "For primitive weapons that are not thrown, such as bows and blowpipes."
DATA 1
DATA "AVG","1D","01S","DEX","DEX","Firing a bow or blowpipe."
DATA "Average (8+) Gun Combat check (1D seconds, DEX)."

DATA "Gun Combat (Energy)"
DATA "Using advanced energy weapons like laser pistols or plasma rifles."
DATA 1
DATA "AVG","1D","01S","DEX","DEX","Firing an energy weapon"
DATA "Average (8+) Gun Combat check (1D seconds, DEX)."

DATA "Gun Combat (Slug)"
DATA "Weapons that fire a solid projectile such as the autorifle or gauss rifle."
DATA 1
DATA "AVG","1D","01S","DEX","DEX","Firing a Gun"
DATA "Average (8+) Gun Combat check (1D seconds, DEX)."

DATA "Slug"
DATA "Weapons that fire a solid projectile such as the autorifle or gauss rifle."
DATA 1
DATA "AVG","1D","01S","DEX","DEX","Firing a Gun"
DATA "Average (8+) Gun Combat check (1D seconds, DEX)."


DATA "Gun Combat"
DATA "Weapons that fire a solid projectile such as the Revolvers, Autorifles or ACRs."
DATA 1
DATA "AVG","1D","01S","DEX","DEX","Firing a Gun"
DATA "Average (8+) Gun Combat check (1D seconds, DEX)."


DATA "Gun Cbt"
DATA "Weapons that fire a solid projectile such as the Revolvers, Autorifles or ACRs."
DATA 1
DATA "AVG","1D","01S","DEX","DEX","Firing a Gun"
DATA "Average (8+) Gun Combat check (1D seconds, DEX)."

DATA "Body Pistol"
DATA "Conceilable Hand Weapon that fire a solid projectile."
DATA 1
DATA "AVG","1D","01S","DEX","DEX","Firing a Gun"
DATA "Average (8+) Gun Combat check (1D seconds, DEX)."

DATA "Automatic Pistol"
DATA "Hand weapons that fire a solid projectile."
DATA 1
DATA "AVG","1D","01S","DEX","DEX","Firing a Autopistol."
DATA "Average (8+) Gun Combat check (1D seconds, DEX)."

DATA "Revolver"
DATA "Hand weapons that fire a solid projectile."
DATA 1
DATA "AVG","1D","01S","DEX","DEX","Firing a Revolver."
DATA "Average (8+) Gun Combat check (1D seconds, DEX)."

DATA "Carbine"
DATA "Mid ranging Weapons that fire a solid projectile."
DATA 1
DATA "AVG","1D","01S","DEX","DEX","Firing a Carbine."
DATA "Average (8+) Gun Combat check (1D seconds, DEX)."

DATA "Rifle"
DATA "Far ranging Weapons that fire a solid projectile."
DATA 1
DATA "AVG","1D","01S","DEX","DEX","Firing a Rifle"
DATA "Average (8+) Gun Combat check (1D seconds, DEX)."

DATA "Shotgun"
DATA "Weapons that fire shot."
DATA 1
DATA "AVG","1D","01S","DEX","DEX","Firing a Shotgun"
DATA "Average (8+) Gun Combat check (1D seconds, DEX)."

DATA "Automatic Rifle"
DATA "Weapons that fire a solid projectile such as the autorifle or gauss rifle on automatic."
DATA 1
DATA "AVG","1D","01S","DEX","DEX","Firing a Automatic Rifle."
DATA "Average (8+) Gun Combat check (1D seconds, DEX)."

DATA "Auto Rifle"
DATA "Weapons that fire a solid projectile such as the autorifle or gauss rifle on automatic."
DATA 1
DATA "AVG","1D","01S","DEX","DEX","Firing a Automatic Rifle."
DATA "Average (8+) Gun Combat check (1D seconds, DEX)."

DATA "Submachine Gun"
DATA "Weapons that fire a solid projectile on automatic."
DATA 1
DATA "AVG","1D","01S","DEX","DEX","Firing a SMG."
DATA "Average (8+) Gun Combat check (1D seconds, DEX)."

DATA "SMG"
DATA "Weapons that fire a solid projectile on automatic."
DATA 1
DATA "AVG","1D","01S","DEX","DEX","Firing a SMG."
DATA "Average (8+) Gun Combat check (1D seconds, DEX)."


DATA "Laser carbine"
DATA "Weapons that fire an energy beam."
DATA 1
DATA "AVG","1D","01S","DEX","DEX","Firing a Laser Carbine."
DATA "Average (8+) Gun Combat check (1D seconds, DEX)."

DATA "Laser Rifle"
DATA "Weapons that fire an energy beam."
DATA 1
DATA "AVG","1D","01S","DEX","DEX","Firing a Laser Rifle."
DATA "Average (8+) Gun Combat check (1D seconds, DEX)."

DATA "Energy"
DATA "Weapons that fire an energy beam."
DATA 1
DATA "AVG","1D","01S","DEX","DEX","Firing a Laser Rifle."
DATA "Average (8+) Gun Combat check (1D seconds, DEX)."


DATA "Combat Rifleman"
DATA "Military Weapons that fire a solid projectile such as the autorifle or gauss rifle."
DATA 1
DATA "AVG","1D","01S","DEX","DEX","Firing a Gun"
DATA "Average (8+) Gun Combat check (1D seconds, DEX)."

'HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH

'heavy Weapons
'The Heavy Weapons skill covers man-portable and larger weapons that cause extreme property damage, such as rocket launchers, artillery and large plasma weapons.
'sPeCialities
DATA "Heavy Weapons"
DATA "Missile launchers, Flamethrowers and man portable fusion and plasma."
DATA 2
DATA "AVG","1D","01S","DEX","DEX","Firing a Heavy Weapon at a Visible Target"
DATA ": Average (8+) Heavy Weapons check (1D seconds, DEX)."
DATA "DIF","1D","10S","INT","INT","Firing an Heavy Weapon using Indirect Fire"
DATA ": Diffcult (10+) Heavy Weapons check (1D x 10 seconds, INT)."


DATA "Heavy Weapons (artillery)"
DATA "Fixed guns, mortars and other indirect-fire weapons."
DATA 2
DATA "AVG","1D","01S","DEX","DEX","Firing a Heavy Weapon at a Visible Target"
DATA ": Average (8+) Heavy Weapons check (1D seconds, DEX)."
DATA "DIF","1D","10S","INT","INT","Firing an Heavy Weapon using Indirect Fire"
DATA ": Diffcult (10+) Heavy Weapons check (1D x 10 seconds, INT)."

DATA "Heavy Weapons (Man Portable)"
DATA "Missile launchers, Flamethrowers and man portable fusion and plasma."
DATA 2
DATA "AVG","1D","01S","DEX","DEX","Firing a Heavy Weapon at a Visible Target"
DATA ": Average (8+) Heavy Weapons check (1D seconds, DEX)."
DATA "DIF","1D","10S","INT","INT","Firing an Heavy Weapon using Indirect Fire"
DATA ": Diffcult (10+) Heavy Weapons check (1D x 10 seconds, INT)."


DATA "Heavy Weapons (vehicle)"
DATA "Large weapons typically mounted on vehicles or strongpoints such as tank guns and autocannon."
DATA 2
DATA "AVG","1D","01S","DEX","DEX","Firing a Heavy Weapon at a Visible Target"
DATA ": Average (8+) Heavy Weapons check (1D seconds, DEX)."
DATA "DIF","1D","10S","INT","INT","Firing an Heavy Weapon using Indirect Fire"
DATA ": Diffcult (10+) Heavy Weapons check (1D x 10 seconds, INT)."

DATA "Hunting"
DATA "The individual is skilled in tracking and hunting animals. In animal encounter situations, this skill is used to enhance the chance of any specific type of achieving surprise on such animals, and of surviving such encounters."
DATA 2
DATA "AVG","1D","10M","INT","DEX","Tracking and approaching a Herbivore"
DATA ": Average (8+) Hunting check (1D x 10 Minutes, INT, DEX)."
DATA "DIF","1D","10M","INT","DEX","Tracking and approaching a Carnivore"
DATA ": Average (8+) Hunting check (1D x 10 Minutes, INT, DEX)."


'IIIIIIIIIIIIIIIIIIIIIIIIIII

'Instruction: Individuals have extensive training In instructfng students in a clear and lucid manner and
'providing motivation for learning.

'Players with Instructional expertise are capable of training recruits to carry out
'basic military functions. A player must have at least Instruction-1 to conduct any training at all. The more involved effects of training large bodies of men and the effects, of
'differing levels of instructional expertise are covered In the recruiting section of the book.

'In addition to general training functions, players with Instructional expertise may impart knowledge of
'certain well-understood skills to other players. Players may  impart skills to other players up to a
'level of one less than their instructional skill and one less than their own skill level in the skill being taught.
'Thus, a player with Instruction 4, Recon-5 and Demolitions-2 could teach another player Recon-3 and Demolitions-1.

'Each level of each skill taught requires six weeks of instruction during which the referee should severely curtail both players'
'activltles, or a SIX month course with other activities somewhat less curtailed. At the
'concluston of the course. the learnlng player must roll 9+ on two dice to achieve the skill.
'with a DM of +1 for Intel 8+ and 2 for lntel 10+.
'Players cannot teach the instructional skill to other players. Since the greatest asset an individual has is his pool of skills,
'the referee should exercise great caution In allowing players to hire nonplayer characters as Instructors.

DATA "instruction"
DATA "Individuals have extensive training In instructing students in a clear and lucid manner and providing motivation for learning."
DATA 2
DATA "DIF","1D","30D","INT","EDU","Teaching a basic skill 0-1"
DATA ""
DATA "DIF","1D","90D","INT","EDU","Teaching a complex skill 2-3"
DATA ""

DATA "Interrogation"
DATA "The skill to get inforamtion from unwilling subjects."
DATA 1
DATA "DIF","1D","01H","EDU","EDU"
DATA "Extracting information from an opposing subject."
DATA ": Routine (6+) Science check (1D minutes, EDU)."

DATA "investigate"
DATA "The Investigate skill incorporates keen observation, forensics, and detailed analysis."
DATA 2
DATA "AVG","1D","10M","INT","INT","Searching a Crime Scene For Clues"
DATA ": Average (8+) Investigate check (1D x 10 minutes, INT)."

DATA "DIF","1D","01H","INT","INT","Watching a Bank of Security Monitors in a Starport, for a Specifc Criminal"
DATA ": Diffcult (10+) Investigate check (1D hours, INT)."

'JJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJJ

DATA "J-drive"
DATA "Maintaining and operating a spacecraft's Jump drive."
DATA 1
DATA "EAS","1D","10M","EDU","EDU","Making a Jump"
DATA ": Easy (4+) Engineer (j-drive) check (1D x 10 minutes, EDU)."

DATA "Jack-of-all-Trades"
DATA "Jack-of-All-Trades skill reduces the unskilled penalty received for not having the appropriate skill by one for every level of Jack-of-All-Trades."

DATA 0

DATA "Jack of all Trades"
DATA "Jack-of-All-Trades skill reduces the unskilled penalty received for not having the appropriate skill by one for every level of Jack-of-All-Trades."
DATA 0

DATA "JOT"
DATA "Jack-of-All-Trades skill reduces the unskilled penalty received for not having the appropriate skill by one for every level of Jack-of-All-Trades."

DATA 0

DATA "Jack-o-T"
DATA "Jack-of-All-Trades skill reduces the unskilled penalty received for not having the appropriate skill by one for every level of Jack-of-All-Trades."

DATA 0

'LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL

'language
'There are numerous different Language specialities, each one covering reading and writing a different
'language. All Travellers can speak and read their native language without needing the Language skill,
'and automated computer translator programs mean Language skills are not always needed on other
'worlds. Having Language 0 implies the Traveller has a smattering of simple phrases in several languages.
'sPeCialities
'There are, of course, as many specialities of Language as there are actual languages. Those presented here are
'examples from the Third Imperium setting. anglic: The common trade language of the Third
'Imperium, derived originally from the English spoken in the Rule of Man.

'vilani: The language spoken by the Vilani of the First
'Imperium; the ‘Latin' of the Third Imperium.
'Zdetl: The Zhodani spoken language.
'oynprith: The Droyne ritual language.
'Ordering a Meal, Asking for Basic Directions: Routine (6+) Language check (1D seconds, EDU).
'Holding a Simple Conversation: Average (8+) Language check (1D x 10 seconds, EDU).
'Understanding a Complex Technical Document or Report: Very Diffcult (12+) Language check (1D minutes, EDU).



DATA "leadership"
DATA "The Leadership skill is for directing, inspiring and rallying allies and comrades."
DATA 2
DATA "AVG","1D","01S","SOC","SOC","Shouting an Order."
DATA ": Average (8+) Leadership check (1D seconds, SOC)."
DATA "DIF","1D","01S","SOC","SOC","Rallying Shaken Troops"
DATA ": Diffcult (10+) Leadership check (1D seconds, SOC)."

DATA "leader"
DATA "The Leadership skill is for directing, inspiring and rallying allies and comrades."
DATA 2
DATA "AVG","1D","01S","SOC","INT","Shouting an Order"
DATA ": Average (8+) Leadership check (1D seconds, SOC)."
DATA "DIF","1D","01S","SOC","INT","Rallying Shaken Troops"
DATA ": Diffcult (10+) Leadership check (1D seconds, SOC)."


DATA "Liaison"
DATA "The individual is trained in the art of dealing with others; this skill is usable in relations with members of military units, citizens in a community, and with alien or foreign cultures."
DATA 1
DATA "AVG","1D","01S","SOC","INT","Establishing contact."
DATA ": Average (8+) Liaison check (1D seconds, SOC)."


DATA "Life support"
DATA "Covers oxygen generators, heating and lighting and other necessary life support systems."
DATA 1
DATA "AVG","1D","01M","EDU","EDU","Safely Reducing Power to Life Support to Prolong a Ship's Battery Life"
DATA ": Average (8+) Engineer (life support) check (1D minutes, EDU)."

'MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM

DATA "M-drive"
DATA "Maintaining and operating a spacecraft's manoeuvre drive, as well as its artifcial gravity. Overcharging a Thruster Plate to Increase a Ship's"
DATA 1
DATA "AVG","1D","10S","INT","INT","Estimating a Ship's Tonnage From its Observed Performance"
DATA ": Average (8+) Engineer (m-drive) check (1D x 10 seconds, INT)."

DATA "Mechanical"
DATA "The Mechanic skill allows maintaining and repairing most equipment - some advanced equipment and spacecraft components require the Engineer skill. Unlike the narrower and more focussed Engineer or Science skills, Mechanic does not allow to build new devices or alter existing ones - it is purely for repairs and maintenance but covers all types of equipment."

DATA 1
DATA "AVG","1D","01M","INT","EDU","Repairing a Damaged System in the Field"
DATA ": Average (8+) Mechanic check (1D minutes, INT or EDU)."

DATA "Mechanic"
DATA "The Mechanic skill allows maintaining and repairing most equipment - some advanced equipment and spacecraft components require the Engineer skill. Unlike the narrower and more focussed Engineer or Science skills, Mechanic does not allow to build new devices or alter existing ones - it is purely for repairs and maintenance but covers all types of equipment."
DATA 1
DATA "AVG","1D","01M","INT","EDU","Repairing a Damaged System in the Field"
DATA ": Average (8+) Mechanic check (1D minutes, INT or EDU)."


DATA "Medic"
DATA "The Medic skill covers emergency first aid and battlefield triage as well as diagnosis, treatment, surgery and longterm care."
DATA 3
DATA "AVG","1D","01M","EDU","EDU","First Aid, The patient regains lost characteristic points equal to the Effect."
DATA ": Average (8+) Medic check (1D minutes, EDU)."

DATA "AVG","1D","01H","EDU","EDU","Treat Poison or Disease"
DATA ": Average (8+) Medic check (1D 'hours, EDU)."

DATA "AVG","1D","01H","EDU","EDU","Long-term Care"
DATA ": Average (8+) Medic check (1D hours, 'EDU)."

DATA "Medical"
DATA "The Medic skill covers emergency first aid and battlefield triage as well as diagnosis, treatment, surgery and longterm care."
DATA 3
DATA "AVG","1D","01M","EDU","EDU","First Aid, The patient regains lost characteristic points equal to the Effect."
DATA ": Average (8+) Medic check (1D minutes, EDU)."

DATA "AVG","1D","01H","EDU","EDU","Treat Poison or Disease"
DATA ": Average (8+) Medic check (1D 'hours, EDU)."

DATA "AVG","1D","01H","EDU","EDU","Long-term Care"
DATA ": Average (8+) Medic check (1D hours, 'EDU)."



DATA "Melee"
DATA "Punching, kicking and wrestling; using improvised weapons in a bar brawl."
DATA 1
DATA "AVG","1D","01S","STR","DEX","Striking without a weapon"
DATA ": Average (8+) Melee (blade) check (1D seconds, STR or DEX)."

DATA "Brawling"
DATA "Punching, kicking and wrestling; using improvised weapons in a bar brawl."
DATA 1
DATA "AVG","1D","01S","STR","DEX","Striking without a weapon"
DATA ": Average (8+) Melee (blade) check (1D seconds, STR or DEX)."



DATA "Melee (unarmed)"
DATA "Punching, kicking and wrestling; using improvised weapons in a bar brawl."
DATA 1
DATA "AVG","1D","01S","STR","DEX","Striking without a weapon"
DATA ": Average (8+) Melee (blade) check (1D seconds, STR or DEX)."

DATA "Melee (Blade)"
DATA "Attacking with swords, rapiers, blades and other edged weapons."
DATA 1
DATA "AVG","1D","01S","STR","DEX","Attacking with a Sword"
DATA ": Average (8+) Melee (blade) check (1D seconds, STR or DEX)."

DATA "Melee (bludgeon)"
DATA "Attacking with maces, clubs, staves and so on."
DATA 1
DATA "AVG","1D","01S","STR","DEX","Attacking with a club"
DATA ": Average (8+) Melee (blade) check (1D seconds, STR or DEX)."

DATA "Melee (natural)"
DATA "Weapons that are part of an alien or creature, such as claws or teeth."
DATA 1
DATA "AVG","1D","01S","STR","DEX","Attacking with a Stinger"
DATA ": Average (8+) Melee (blade) check (1D seconds, STR or DEX)."

'OOOOOOOOOOOOOOOOOOOOOOOOOOOOO

DATA "ornithopter"
DATA ": For vehicles that fly through the use of flapping wings."
DATA 2
DATA "ROU","1D","01M","DEX","DEX","Landing Safely"
DATA ": Routine (6+) Flyer check (1D minutes, DEX)."
DATA "AVG","1D","10M","DEX","DEX","Racing Another Flyer : Opposed Flyer check"
DATA ": Opposed Flyer check (1D x 10 minutes, DEX)."
'NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
DATA "navigation"
DATA "Navigation is the planetside counterpart of astrogation, covering plotting courses and fnding directions on the ground."
DATA 2
DATA "AVG","1D","10M","INT","EDU","Plotting a Course Using an Orbiting Satellite Beacon"
DATA ":Average (8+) Navigation check (1D x 10 minutes, INT or EDU)."
DATA "DIF","1D","01H","INT","INT","Avoiding Getting Lost in Thick Jungle"
DATA ": Diffcult (10+) Navigation check (1D hours, INT)."


'PPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPPP

DATA "Persuade"
DATA "Persuade is a more casual, informal version of Diplomat. It covers fast talking, bargaining, wheedling and bluffing. It also covers bribery or intimidation."
DATA 4
DATA "AVG","1D","01M","INT","SOC","Bluffing Your Way Past a Guard"
DATA "Opposed Persuade check (1D minutes, INT or SOC)."

DATA "AVG","1D","01M","INT","SOC","Haggling in a Bazaar"
DATA "Opposed Persuade check (1D minutes, INT or SOC)."

DATA "AVG","1D","01M","STR","SOC","Intimidating a Thug"
DATA "Opposed Persuade check (1D minutes, STR or SOC)."

DATA "FOR","1D","10M","SOC","SOC","Asking the Alien Space Princess to Marry You"
DATA "Formidable (14+) Persuade check (1D x 10 minutes, SOC)."

DATA "Bribery"
DATA "Persuade is a more casual, informal version of Diplomat. It covers fast talking, bargaining, wheedling and bluffing. It also covers bribery or intimidation."
DATA 4
DATA "AVG","1D","01M","INT","SOC","Bluffing Your Way Past a Guard"
DATA "Opposed Persuade check (1D minutes, INT or SOC)."

DATA "AVG","1D","01M","INT","SOC","Haggling in a Bazaar"
DATA "Opposed Persuade check (1D minutes, INT or SOC)."

DATA "AVG","1D","01M","STR","SOC","Intimidating a Thug"
DATA "Opposed Persuade check (1D minutes, STR or SOC)."

DATA "FOR","1D","10M","SOC","SOC","Asking the Alien Space Princess to Marry You"
DATA "Formidable (14+) Persuade check (1D x 10 minutes, SOC)."

'Pilot
'The Pilot skill specialities cover different forms of
''spacecraft. See Spacecraft Operations chapter for more details.
'sPeCialities
DATA "Pilot (small Craft)"
DATA "Shuttles and other craft under 100 tons."
DATA 0


DATA "Ship's Boat"
DATA "Shuttles and other craft under 100 tons."
DATA 0


DATA "Pilot (spacecraft)"
DATA "Trade ships and other vessels between 100 and 5,000 tons."
DATA 0
DATA "Pilot (Capital ships)"
DATA "Battleships and other ships over 5,000 tons."
DATA 0
DATA "Pilot"
DATA "Trade ships and other vessels between 100 and 5,000 tons."
DATA 0




DATA "Power-Plant"
DATA "Maintaining and operating a spacecraft's power plant."
DATA 1
DATA "DIF","1D","01M","INT","INT","Monitoring an Enemy ship's Power Output to Determine its Capabilities"
DATA ": Diffcult (10+) Engineer (power) check (1D minutes, INT)."


'RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR

DATA "recon"
DATA "Being able to scout out dangers and spot threats, unusual objects or out of place people."
DATA 2
DATA "AVG","1D","01M","INT","INT"
DATA "Working Out the Routine of a Trio of Guard Patrols"
DATA ": Average (8+) Recon check (1D x 10 minutes, INT)."

DATA "AVG","1D","01D","INT","INT"
DATA "Spotting the Sniper Before he Shoots You"
DATA ": Recon check (1D x 10 seconds, INT) opposed by Stealth (DEX) check."

DATA "Remote"
DATA "Using telepresence to remotely control drones, missiles, robots and other devices."
DATA 1
DATA "ROU","1D","01H","DEX","DEX","Using a Mining Drone to Excavate an Asteroid"
DATA ": Routine (6+) Electronics (remote ops) check (1D hours, DEX)."

DATA "rotor"
DATA "For helicopters, tilt-rotors and aerodynes."
DATA 2
DATA "ROU","1D","01M","DEX","DEX","Landing Safely"
DATA ": Routine (6+) Flyer check (1D minutes, DEX)."
DATA "AVG","1D","10M","DEX","DEX","Racing Another Flyer : Opposed Flyer check"
DATA ": Opposed Flyer check (1D x 10 minutes, DEX)."

'SSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSSS

DATA "science"
DATA "The Science skill covers not just knowledge but also practical application of that knowledge where such practical application is possible. There are a large range of specialities."
DATA 2
DATA "ROU","1D","01M","EDU","EDU"
DATA "Remembering a Commonly Known Fact"
DATA ": Routine (6+) Science check (1D minutes, EDU)."

DATA "AVG","1D","01D","INT","INT"
DATA "Researching a Problem Related to a Field of Science"
DATA ": Average (8+) Science check (1D days, INT)."




DATA "archaeology"
DATA "The study of ancient civilisations, including the previous Imperiums and Ancients. It also covers techniques of investigation and excavations."
DATA 2
DATA "ROU","1D","01M","EDU","EDU"
DATA "Remembering a Commonly Known Fact"
DATA ": Routine (6+) Science check (1D minutes, EDU)."

DATA "AVG","1D","01D","INT","INT"
DATA "Researching a Problem Related to a Field of Science"
DATA ": Average (8+) Science check (1D days, INT)."


DATA "astronomy"
DATA "The study of stars and celestial pheonomina."
DATA 2
DATA "ROU","1D","01M","EDU","EDU"
DATA "Remembering a Commonly Known Fact"
DATA ": Routine (6+) Science check (1D minutes, EDU)."

DATA "AVG","1D","01D","INT","INT"
DATA "Researching a Problem Related to a Field of Science"
DATA ": Average (8+) Science check (1D days, INT)."

DATA "biology"
DATA "The study of living organisms."
DATA 2
DATA "ROU","1D","01M","EDU","EDU"
DATA "Remembering a Commonly Known Fact"
DATA ": Routine (6+) Science check (1D minutes, EDU)."

DATA "AVG","1D","01D","INT","INT"
DATA "Researching a Problem Related to a Field of Science"
DATA ": Average (8+) Science check (1D days, INT)."

DATA "Chemistry"
DATA "The study of matter at the atomic, molecular, and macromolecular levels."
DATA 2
DATA "ROU","1D","01M","EDU","EDU"
DATA "Remembering a Commonly Known Fact"
DATA ": Routine (6+) Science check (1D minutes, EDU)."

DATA "AVG","1D","01D","INT","INT"
DATA "Researching a Problem Related to a Field of Science"
DATA ": Average (8+) Science check (1D days, INT)."

DATA "Cosmology"
DATA "The study of universe and its creation."
DATA 2
DATA "ROU","1D","01M","EDU","EDU"
DATA "Remembering a Commonly Known Fact"
DATA ": Routine (6+) Science check (1D minutes, EDU)."

DATA "AVG","1D","01D","INT","INT"
DATA "Researching a Problem Related to a Field of Science"
DATA ": Average (8+) Science check (1D days, INT)."

DATA "Cybernetics"
DATA "The study of blending living and synthetic life."
DATA 2
DATA "ROU","1D","01M","EDU","EDU"
DATA "Remembering a Commonly Known Fact"
DATA ": Routine (6+) Science check (1D minutes, EDU)."

DATA "AVG","1D","01D","INT","INT"
DATA "Researching a Problem Related to a Field of Science"
DATA ": Average (8+) Science check (1D days, INT)."

DATA "economics"
DATA "The study of trade and markets."
DATA 2
DATA "ROU","1D","01M","EDU","EDU"
DATA "Remembering a Commonly Known Fact"
DATA ": Routine (6+) Science check (1D minutes, EDU)."

DATA "AVG","1D","01D","INT","INT"
DATA "Researching a Problem Related to a Field of Science"
DATA ": Average (8+) Science check (1D days, INT)."

DATA "genetics"
DATA "The study of genetic codes and engineering."
DATA 2
DATA "ROU","1D","01M","EDU","EDU"
DATA "Remembering a Commonly Known Fact"
DATA ": Routine (6+) Science check (1D minutes, EDU)."

DATA "AVG","1D","01D","INT","INT"
DATA "Researching a Problem Related to a Field of Science"
DATA ": Average (8+) Science check (1D days, INT)."

DATA "history"
DATA "The study of the past, as seen through documents and records as opposed to physical artefacts."
DATA 2
DATA "ROU","1D","01M","EDU","EDU"
DATA "Remembering a Commonly Known Fact"
DATA ": Routine (6+) Science check (1D minutes, EDU)."

DATA "AVG","1D","01D","INT","INT"
DATA "Researching a Problem Related to a Field of Science"
DATA ": Average (8+) Science check (1D days, INT)."

DATA "linguistics"
DATA "The study of languages."
DATA 2
DATA "ROU","1D","01M","EDU","EDU"
DATA "Remembering a Commonly Known Fact"
DATA ": Routine (6+) Science check (1D minutes, EDU)."

DATA "AVG","1D","01D","INT","INT"
DATA "Researching a Problem Related to a Field of Science"
DATA ": Average (8+) Science check (1D days, INT)."

DATA "Philosophy"
DATA "The study of beliefs and religions."
DATA 2
DATA "ROU","1D","01M","EDU","EDU"
DATA "Remembering a Commonly Known Fact"
DATA ": Routine (6+) Science check (1D minutes, EDU)."

DATA "AVG","1D","01D","INT","INT"
DATA "Researching a Problem Related to a Field of Science"
DATA ": Average (8+) Science check (1D days, INT)."

DATA "Physics"
DATA "The study of the fundamental forces."
DATA 2
DATA "ROU","1D","01M","EDU","EDU"
DATA "Remembering a Commonly Known Fact"
DATA ": Routine (6+) Science check (1D minutes, EDU)."

DATA "AVG","1D","01D","INT","INT"
DATA "Researching a Problem Related to a Field of Science"
DATA ": Average (8+) Science check (1D days, INT)."

DATA "Planetology"
DATA "The study of planet formation and evolution."
DATA 2
DATA "ROU","1D","01M","EDU","EDU"
DATA "Remembering a Commonly Known Fact"
DATA ": Routine (6+) Science check (1D minutes, EDU)."

DATA "AVG","1D","01D","INT","INT"
DATA "Researching a Problem Related to a Field of Science"
DATA ": Average (8+) Science check (1D days, INT)."

DATA "Psionicology"
DATA "The study of psionic powers and phenomena."
DATA 2
DATA "ROU","1D","01M","EDU","EDU"
DATA "Remembering a Commonly Known Fact"
DATA ": Routine (6+) Science check (1D minutes, EDU)."

DATA "AVG","1D","01D","INT","INT"
DATA "Researching a Problem Related to a Field of Science"
DATA ": Average (8+) Science check (1D days, INT)."

DATA "Psychology"
DATA "The study of thought and society."
DATA 2
DATA "ROU","1D","01M","EDU","EDU"
DATA "Remembering a Commonly Known Fact"
DATA ": Routine (6+) Science check (1D minutes, EDU)."
DATA "AVG","1D","01D","INT","INT"
DATA "Researching a Problem Related to a Field of Science"
DATA ": Average (8+) Science check (1D days, INT)."








DATA "robotics"
DATA "The study of robot construction and use."
DATA 2
DATA "ROU","1D","01M","EDU","EDU"
DATA "Remembering a Commonly Known Fact"
DATA ": Routine (6+) Science check (1D minutes, EDU)."

DATA "AVG","1D","01D","INT","INT"
DATA "Researching a Problem Related to a Field of Science"
DATA ": Average (8+) Science check (1D days, INT)."

DATA "sophontology"
DATA "The study of intelligent living creatures."
DATA 2
DATA "ROU","1D","01M","EDU","EDU"
DATA "Remembering a Commonly Known Fact"
DATA ": Routine (6+) Science check (1D minutes, EDU)."

DATA "AVG","1D","01D","INT","INT"
DATA "Researching a Problem Related to a Field of Science"
DATA ": Average (8+) Science check (1D days, INT)."

DATA "Xenology"
DATA "The study of alien life forms"
DATA 2
DATA "ROU","1D","01M","EDU","EDU"
DATA "Remembering a Commonly Known Fact"
DATA ": Routine (6+) Science check (1D minutes, EDU)."

DATA "AVG","1D","01D","INT","INT"
DATA "Researching a Problem Related to a Field of Science"
DATA ": Average (8+) Science check (1D days, INT)."



DATA "Sensors"
DATA "The use and interpretation of data from electronic sensor devices, from observation satellites and remote probes to thermal imaging and densitometers."
DATA 2
DATA "ROU","1D","10M","INT","EDU","Making a Detailed Sensor Scan"
DATA ": Routine (6+) Electronics (sensors) check (1D x 10 minutes, INT or EDU)."
DATA "AVG","1D","01H","INT","INT","Analysing Sensor Data"
DATA ": Average (8+) Electronics (sensors) check (1D hours, INT)."


'DATA "seafarer
'DATA "The Seafarer skill covers all manner of watercraft and ocean travel.
'sPeCialities                                                 '
DATA "Seafarer (ocean ships)"
DATA "For motorised sea-going vessels."
DATA 0
DATA "Seafarer (Personal)"
DATA "Used for very small waterborne craft such as canoes and rowboats."
DATA 0

DATA "Seafarer ( (sail)"
DATA "This skill is for wind-driven watercraft."
DATA 0

DATA "Seafarer (submarine)"
DATA "For vehicles that travel underwater."
DATA 0


DATA "stealth"
DATA "Being adept at staying unseen, unheard, and unnoticed."
DATA 2
DATA "AVG","1D","10S","INT","INT","Sneaking Past a Guard, opposed by Recon"
DATA ": Stealth check (1D x 10 seconds, DEX) opposed by Recon (INT) check."

DATA "AVG","1D","01M","DEX","DEX","Avoiding Detection by a Security Patrol, opposed by recon"
DATA "Stealth check (1D minutes, DEX) opposed by Recon (INT) check."













DATA "steward"
DATA "The Steward skill allows to serve and care for nobles and high-class passengers. It covers everything from proper address and behaviour to cooking and tailoring, as well as basic management skills. Steward skill is necessary on any ship offering High Passage."
DATA 2
DATA "AVG","1D","01H","EDU","EDU"
DATA "Cooking a Fine Meal"
DATA "Average (8+) Steward check (1D hours, EDU)."

DATA "DIF","1D","01M","SOC","SOC"
DATA "Calming Down an Angry Duke who has Just Been Told you Will not be Jumping to his Destination on Time"
DATA "Diffcult (10+) Steward check (1D minutes, SOC)"



DATA "streetwise"
DATA "Understanding the urban environment and the power structures in society, knowing . On homeworld and in related systems, it means knowing criminal contacts and fixers. On other worlds, it means to quickly intuit power structures and fitting into local underworlds."
DATA 2
DATA "AVG","1D","10H","INT","INT","Finding a Dealer in Illegal Materials or Technologies"
DATA "Average (8+) Streetwise check (1D x 10 hours, INT)."

DATA "AVG","1D","10H","INT","INT","Evading a Police Search"
DATA "Streetwise check (1D x 10 minutes, INT) opposed by Recon (INT) check."


DATA "survival"
DATA "The Survival skill is the wilderness counterpart of the urban Streetwise skill - being trained to survive in the wild, build shelters, hunt or trap animals, avoid exposure and so forth. He can recognise plants and animals of his homeworld and related planets, and picking up on common clues and traits even on unfamiliar worlds."
DATA 2
DATA "AVG","1D","01D","EDU","EDU","Gathering Supplies in the Wilderness to Survive for a week"
DATA ": Average (8+) Survival check (1D days, EDU)."
DATA "AVG","1D","10S","INT","EDU","Identifying a Poisonous Plant"
DATA ": Average (8+) Survival check (1D x 10 seconds, INT or EDU)."

'TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT
DATA "Tactics"
DATA "This skill covers tactical planning and decision making, from board games to squad level combat to fleet engagements."
DATA 1
DATA "AVG","1D","10H","INT","INT","Developing a Strategy for Attacking an Enemy Base"
DATA ": Average (8+) Tactics (military) check (1D x 10 hours, INT)."


'UUUUUUUUUUUUUUUUUUUUUUUUUUUUUU

DATA "unarmed"
DATA "Punching, kicking and wrestling; using improvised weapons in a bar brawl."
DATA 1
DATA "AVG","1D","01S","STR","DEX","Throwing a punch."
DATA ": Average (8+) Melee (blade) check (1D seconds, STR or DEX)."


'VVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVVV
DATA "Vacc Suit"
DATA "The Vacc Suit skill allows to wear and operate spacesuits and environmental suits. No Vacc Suit checks under ordinary circumstances - merely possessing the skill is enough. Without the requisite Vacc Suit skill for the suit, suffer DM-2 to all skill checks made while wearing a suit for each missing level. This skill also permits to operate advanced battle armour."
DATA 1
DATA "AVG","1D","01M","EDU","EDU","Performing a Systems Check on Battle Dress"
DATA ": Average (8+) Vacc Suit check (1D minutes, EDU)."

DATA "Battle Dress"
DATA "The Vacc Suit skill allows to wear and operate spacesuits and environmental suits. No Vacc Suit checks under ordinary circumstances - merely possessing the skill is enough. Without the requisite Vacc Suit skill for the suit, suffer DM-2 to all skill checks made while wearing a suit for each missing level. This skill also permits to operate advanced battle armour."
DATA 1
DATA "AVG","1D","01M","EDU","EDU","Performing a Systems Check on Battle Dress"
DATA ": Average (8+) Vacc Suit check (1D minutes, EDU)."


'WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW

DATA "Wing"
DATA "For jets, vectored thrust aircraft and aeroplanes using a lifting body."
DATA 2
DATA "ROU","1D","01M","DEX","DEX","Landing Safely"
DATA ": Routine (6+) Flyer check (1D minutes, DEX)."
DATA "AVG","1D","10M","DEX","DEX","Racing Another Flyer : Opposed Flyer check"
DATA ": Opposed Flyer check (1D x 10 minutes, DEX)."



DATA "END"


