package A_Sintactic_Goto is

    type Small_Integer is range -32_000 .. 32_000;

    type Goto_Entry is record
        Nonterm  : Small_Integer;
        Newstate : Small_Integer;
    end record;

  --pragma suppress(index_check);

    subtype Row is Integer range -1 .. Integer'Last;

    type Goto_Parse_Table is array (Row range <>) of Goto_Entry;

    Goto_Matrix : constant Goto_Parse_Table :=
       ((-1,-1)  -- Dummy Entry.
-- State  0
,(-3, 1),(-2, 3)
-- State  1

-- State  2
,(-4, 5)
-- State  3

-- State  4
,(-7, 8)

-- State  5

-- State  6

-- State  7
,(-9, 11),(-8, 10)
-- State  8

-- State  9
,(-5, 13)
-- State  10

-- State  11

-- State  12

-- State  13
,(-19, 24)
,(-18, 23),(-17, 22),(-15, 21),(-14, 19)
,(-13, 18),(-12, 17),(-11, 28),(-3, 20)

-- State  14

-- State  15
,(-9, 29)
-- State  16
,(-10, 31)
-- State  17

-- State  18

-- State  19

-- State  20

-- State  21

-- State  22

-- State  23

-- State  24

-- State  25

-- State  26

-- State  27
,(-28, 42),(-26, 40)
,(-25, 39),(-24, 38),(-23, 37),(-22, 36)
,(-6, 35)
-- State  28

-- State  29

-- State  30

-- State  31

-- State  32

-- State  33

-- State  34

-- State  35
,(-28, 42),(-26, 40),(-25, 39)
,(-24, 38),(-23, 37),(-22, 52)
-- State  36

-- State  37

-- State  38

-- State  39

-- State  40

-- State  41
,(-28, 57)
,(-27, 53)
-- State  42

-- State  43
,(-28, 57),(-27, 61)
-- State  44
,(-29, 62)

-- State  45

-- State  46

-- State  47

-- State  48

-- State  49

-- State  50

-- State  51

-- State  52

-- State  53

-- State  54
,(-28, 57),(-27, 83)
-- State  55
,(-28, 57),(-27, 84)

-- State  56
,(-28, 57),(-27, 85)
-- State  57

-- State  58

-- State  59
,(-28, 57),(-27, 86)

-- State  60

-- State  61

-- State  62
,(-30, 90)
-- State  63

-- State  64

-- State  65

-- State  66

-- State  67
,(-20, 94)
-- State  68

-- State  69
,(-28, 42),(-26, 40)
,(-25, 39),(-24, 38),(-23, 37),(-22, 36)
,(-6, 96)
-- State  70
,(-28, 57),(-27, 97)
-- State  71
,(-28, 57)
,(-27, 98)
-- State  72
,(-28, 57),(-27, 99)
-- State  73
,(-28, 57)
,(-27, 100)
-- State  74
,(-28, 57),(-27, 101)
-- State  75
,(-28, 57)
,(-27, 102)
-- State  76
,(-28, 57),(-27, 103)
-- State  77
,(-28, 57)
,(-27, 104)
-- State  78
,(-28, 57),(-27, 105)
-- State  79
,(-28, 57)
,(-27, 106)
-- State  80
,(-28, 57),(-27, 107)
-- State  81
,(-28, 57)
,(-27, 108)
-- State  82
,(-28, 57),(-27, 109)
-- State  83

-- State  84

-- State  85

-- State  86

-- State  87
,(-28, 42)
,(-26, 40),(-25, 39),(-24, 38),(-23, 37)
,(-22, 36),(-6, 112)
-- State  88

-- State  89
,(-31, 114),(-28, 57)
,(-27, 115)
-- State  90

-- State  91
,(-16, 119)
-- State  92

-- State  93
,(-15, 121)
-- State  94
,(-21, 124)

-- State  95

-- State  96
,(-28, 42),(-26, 40),(-25, 39),(-24, 38)
,(-23, 37),(-22, 52)
-- State  97

-- State  98

-- State  99

-- State  100

-- State  101

-- State  102

-- State  103

-- State  104

-- State  105

-- State  106

-- State  107

-- State  108

-- State  109

-- State  110

-- State  111

-- State  112
,(-28, 42),(-26, 40)
,(-25, 39),(-24, 38),(-23, 37),(-22, 52)

-- State  113

-- State  114

-- State  115

-- State  116

-- State  117

-- State  118

-- State  119

-- State  120
,(-16, 133)
-- State  121

-- State  122

-- State  123

-- State  124

-- State  125

-- State  126
,(-28, 42),(-26, 40),(-25, 39)
,(-24, 38),(-23, 37),(-22, 36),(-6, 138)

-- State  127

-- State  128

-- State  129
,(-28, 57),(-27, 140)
-- State  130

-- State  131

-- State  132

-- State  133

-- State  134

-- State  135

-- State  136

-- State  137

-- State  138
,(-28, 42),(-26, 40)
,(-25, 39),(-24, 38),(-23, 37),(-22, 52)

-- State  139

-- State  140

-- State  141
,(-16, 148)
-- State  142

-- State  143

-- State  144

-- State  145

-- State  146

-- State  147

-- State  148

-- State  149

-- State  150

-- State  151

-- State  152

-- State  153

-- State  154

);
--  The offset vector
GOTO_OFFSET : array (0.. 154) of Integer :=
( 0,
 2, 2, 3, 3, 4, 4, 4, 6, 6, 7,
 7, 7, 7, 16, 16, 17, 18, 18, 18, 18,
 18, 18, 18, 18, 18, 18, 18, 25, 25, 25,
 25, 25, 25, 25, 25, 31, 31, 31, 31, 31,
 31, 33, 33, 35, 36, 36, 36, 36, 36, 36,
 36, 36, 36, 36, 38, 40, 42, 42, 42, 44,
 44, 44, 45, 45, 45, 45, 45, 46, 46, 53,
 55, 57, 59, 61, 63, 65, 67, 69, 71, 73,
 75, 77, 79, 79, 79, 79, 79, 86, 86, 89,
 89, 90, 90, 91, 92, 92, 98, 98, 98, 98,
 98, 98, 98, 98, 98, 98, 98, 98, 98, 98,
 98, 98, 104, 104, 104, 104, 104, 104, 104, 104,
 105, 105, 105, 105, 105, 105, 112, 112, 112, 114,
 114, 114, 114, 114, 114, 114, 114, 114, 120, 120,
 120, 121, 121, 121, 121, 121, 121, 121, 121, 121,
 121, 121, 121, 121);

subtype Rule        is Natural;
subtype Nonterminal is Integer;

   Rule_Length : array (Rule range  0 ..  69) of Natural := ( 2,
 1, 9, 2, 3, 0, 3, 1, 4,
 1, 2, 2, 0, 1, 1, 1, 1,
 7, 1, 2, 1, 2, 4, 3, 1,
 1, 1, 1, 10, 10, 8, 2, 0,
 4, 2, 1, 1, 1, 1, 1, 7,
 9, 4, 2, 2, 0, 2, 3, 3,
 1, 7, 2, 3, 3, 3, 3, 3,
 3, 3, 3, 3, 3, 3, 3, 3,
 2, 3, 2, 1, 1);
   Get_LHS_Rule: array (Rule range  0 ..  69) of Nonterminal := (-1,
-2,-3,-4,-7,-7,-8,-8,-9,
-10,-10,-5,-5,-11,-11,-11,-11,
-12,-16,-16,-16,-16,-13,-15,-15,
-14,-14,-14,-17,-18,-19,-20,-20,
-21,-6,-6,-22,-22,-22,-22,-23,
-23,-24,-28,-29,-29,-30,-30,-31,
-31,-25,-26,-27,-27,-27,-27,-27,
-27,-27,-27,-27,-27,-27,-27,-27,
-27,-27,-27,-27,-27);
end A_Sintactic_Goto;
