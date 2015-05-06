/**********************************************\
*       Flies.h                                   *
*          by dovotos pcx->gba program         *
/**********************************************/
#define  Flies_WIDTH   16
#define  Flies_HEIGHT  192

#define Red_1       0
#define Red_2       1
#define Orange_1    2
#define Orange_2    3
#define Yellow_1    4
#define Yellow_2    5
#define Green_1     6
#define Green_2     7
#define Blue_1      8
#define Blue_2      9
#define Indigo_1    10
#define Indigo_2    11


const unsigned short FliesData[3072] = {
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0C00, 0x000C,
                    0x0000, 0x0000, 0x0C00, 0x0C0C, 0x0000, 0x0000, 0x0C00, 0x0C0C, 0x000C, 0x0000,
                    0x0000, 0x0C00, 0x0C0C, 0x0000, 0x0000, 0x0000, 0x0C0C, 0x0A0C, 0x0000, 0x0000,
                    0x0C00, 0x030A, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0C00, 0x000C, 0x0000, 0x0000, 0x0C0C, 0x000C, 0x0000, 0x0C00,
                    0x0C0C, 0x000C, 0x0000, 0x0C0C, 0x000C, 0x0000, 0x0C0A, 0x0C0C, 0x0000, 0x0000,
                    0x0A03, 0x000C, 0x0000, 0x0000, 0x0000, 0x0000, 0x0A00, 0x0303, 0x0000, 0x0000,
                    0x0A00, 0x0303, 0x0000, 0x0000, 0x0A00, 0x0303, 0x0000, 0x0000, 0x0A00, 0x0303,
                    0x0000, 0x0000, 0x0000, 0x030A, 0x0000, 0x0000, 0x0000, 0x0A00, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0303, 0x000A, 0x0000, 0x0000,
                    0x0303, 0x000A, 0x0000, 0x0000, 0x0303, 0x000A, 0x0000, 0x0000, 0x0303, 0x000A,
                    0x0000, 0x0000, 0x0A03, 0x0000, 0x0000, 0x0000, 0x000A, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0C00, 0x0C0C, 0x0C0C, 0x0A0C, 0x0C0C, 0x0C0C, 0x0C0C, 0x030A,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0C0A, 0x0C0C, 0x0C0C, 0x000C, 0x0A03, 0x0C0C,
                    0x0C0C, 0x0C0C, 0x0C00, 0x0C0C, 0x0A0C, 0x0303, 0x0000, 0x0000, 0x0A00, 0x0303,
                    0x0000, 0x0000, 0x0A00, 0x0303, 0x0000, 0x0000, 0x0A00, 0x0303, 0x0000, 0x0000,
                    0x0A00, 0x0303, 0x0000, 0x0000, 0x0000, 0x030A, 0x0000, 0x0000, 0x0000, 0x0A00,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0303, 0x0C0A, 0x0C0C, 0x000C, 0x0303, 0x000A,
                    0x0000, 0x0000, 0x0303, 0x000A, 0x0000, 0x0000, 0x0303, 0x000A, 0x0000, 0x0000,
                    0x0303, 0x000A, 0x0000, 0x0000, 0x0A03, 0x0000, 0x0000, 0x0000, 0x000A, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x3500, 0x0035, 0x0000, 0x0000, 0x3500, 0x3535,
                    0x0000, 0x0000, 0x3500, 0x3535, 0x0035, 0x0000, 0x0000, 0x3500, 0x3535, 0x0000,
                    0x0000, 0x0000, 0x3535, 0x3435, 0x0000, 0x0000, 0x3500, 0x2B34, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x3500, 0x0035,
                    0x0000, 0x0000, 0x3535, 0x0035, 0x0000, 0x3500, 0x3535, 0x0035, 0x0000, 0x3535,
                    0x0035, 0x0000, 0x3534, 0x3535, 0x0000, 0x0000, 0x342B, 0x0035, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x3400, 0x2B2B, 0x0000, 0x0000, 0x3400, 0x2B2B, 0x0000, 0x0000,
                    0x3400, 0x2B2B, 0x0000, 0x0000, 0x3400, 0x2B2B, 0x0000, 0x0000, 0x0000, 0x2B34,
                    0x0000, 0x0000, 0x0000, 0x3400, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x2B2B, 0x0034, 0x0000, 0x0000, 0x2B2B, 0x0034, 0x0000, 0x0000,
                    0x2B2B, 0x0034, 0x0000, 0x0000, 0x2B2B, 0x0034, 0x0000, 0x0000, 0x342B, 0x0000,
                    0x0000, 0x0000, 0x0034, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x3500, 0x3535,
                    0x3535, 0x3435, 0x3535, 0x3535, 0x3535, 0x2B34, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x3534, 0x3535, 0x3535, 0x0035, 0x342B, 0x3535, 0x3535, 0x3535, 0x3500, 0x3535,
                    0x3435, 0x2B2B, 0x0000, 0x0000, 0x3400, 0x2B2B, 0x0000, 0x0000, 0x3400, 0x2B2B,
                    0x0000, 0x0000, 0x3400, 0x2B2B, 0x0000, 0x0000, 0x3400, 0x2B2B, 0x0000, 0x0000,
                    0x0000, 0x2B34, 0x0000, 0x0000, 0x0000, 0x3400, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x2B2B, 0x3534, 0x3535, 0x0035, 0x2B2B, 0x0034, 0x0000, 0x0000, 0x2B2B, 0x0034,
                    0x0000, 0x0000, 0x2B2B, 0x0034, 0x0000, 0x0000, 0x2B2B, 0x0034, 0x0000, 0x0000,
                    0x342B, 0x0000, 0x0000, 0x0000, 0x0034, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x2A00, 0x002A, 0x0000, 0x0000, 0x2A00, 0x2A2A, 0x0000, 0x0000, 0x2A00, 0x2A2A,
                    0x002A, 0x0000, 0x0000, 0x2A00, 0x2A2A, 0x0000, 0x0000, 0x0000, 0x2A2A, 0x292A,
                    0x0000, 0x0000, 0x2A00, 0x2729, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x2A00, 0x002A, 0x0000, 0x0000, 0x2A2A, 0x002A,
                    0x0000, 0x2A00, 0x2A2A, 0x002A, 0x0000, 0x2A2A, 0x002A, 0x0000, 0x2A29, 0x2A2A,
                    0x0000, 0x0000, 0x2927, 0x002A, 0x0000, 0x0000, 0x0000, 0x0000, 0x2900, 0x2727,
                    0x0000, 0x0000, 0x2900, 0x2727, 0x0000, 0x0000, 0x2900, 0x2727, 0x0000, 0x0000,
                    0x2900, 0x2727, 0x0000, 0x0000, 0x0000, 0x2729, 0x0000, 0x0000, 0x0000, 0x2900,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x2727, 0x0029,
                    0x0000, 0x0000, 0x2727, 0x0029, 0x0000, 0x0000, 0x2727, 0x0029, 0x0000, 0x0000,
                    0x2727, 0x0029, 0x0000, 0x0000, 0x2927, 0x0000, 0x0000, 0x0000, 0x0029, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x2A00, 0x2A2A, 0x2A2A, 0x292A, 0x2A2A, 0x2A2A,
                    0x2A2A, 0x2729, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x2A29, 0x2A2A, 0x2A2A, 0x002A,
                    0x2927, 0x2A2A, 0x2A2A, 0x2A2A, 0x2A00, 0x2A2A, 0x292A, 0x2727, 0x0000, 0x0000,
                    0x2900, 0x2727, 0x0000, 0x0000, 0x2900, 0x2727, 0x0000, 0x0000, 0x2900, 0x2727,
                    0x0000, 0x0000, 0x2900, 0x2727, 0x0000, 0x0000, 0x0000, 0x2729, 0x0000, 0x0000,
                    0x0000, 0x2900, 0x0000, 0x0000, 0x0000, 0x0000, 0x2727, 0x2A29, 0x2A2A, 0x002A,
                    0x2727, 0x0029, 0x0000, 0x0000, 0x2727, 0x0029, 0x0000, 0x0000, 0x2727, 0x0029,
                    0x0000, 0x0000, 0x2727, 0x0029, 0x0000, 0x0000, 0x2927, 0x0000, 0x0000, 0x0000,
                    0x0029, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x1F00, 0x001F, 0x0000, 0x0000,
                    0x1F00, 0x1F1F, 0x0000, 0x0000, 0x1F00, 0x1F1F, 0x001F, 0x0000, 0x0000, 0x1F00,
                    0x1F1F, 0x0000, 0x0000, 0x0000, 0x1F1F, 0x1E1F, 0x0000, 0x0000, 0x1F00, 0x181E,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x1F00, 0x001F, 0x0000, 0x0000, 0x1F1F, 0x001F, 0x0000, 0x1F00, 0x1F1F, 0x001F,
                    0x0000, 0x1F1F, 0x001F, 0x0000, 0x1F1E, 0x1F1F, 0x0000, 0x0000, 0x1E18, 0x001F,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x1E00, 0x1818, 0x0000, 0x0000, 0x1E00, 0x1818,
                    0x0000, 0x0000, 0x1E00, 0x1818, 0x0000, 0x0000, 0x1E00, 0x1818, 0x0000, 0x0000,
                    0x0000, 0x181E, 0x0000, 0x0000, 0x0000, 0x1E00, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x1818, 0x001E, 0x0000, 0x0000, 0x1818, 0x001E,
                    0x0000, 0x0000, 0x1818, 0x001E, 0x0000, 0x0000, 0x1818, 0x001E, 0x0000, 0x0000,
                    0x1E18, 0x0000, 0x0000, 0x0000, 0x001E, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x1F00, 0x1F1F, 0x1F1F, 0x1E1F, 0x1F1F, 0x1F1F, 0x1F1F, 0x181E, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x1F1E, 0x1F1F, 0x1F1F, 0x001F, 0x1E18, 0x1F1F, 0x1F1F, 0x1F1F,
                    0x1F00, 0x1F1F, 0x1E1F, 0x1818, 0x0000, 0x0000, 0x1E00, 0x1818, 0x0000, 0x0000,
                    0x1E00, 0x1818, 0x0000, 0x0000, 0x1E00, 0x1818, 0x0000, 0x0000, 0x1E00, 0x1818,
                    0x0000, 0x0000, 0x0000, 0x181E, 0x0000, 0x0000, 0x0000, 0x1E00, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x1818, 0x1F1E, 0x1F1F, 0x001F, 0x1818, 0x001E, 0x0000, 0x0000,
                    0x1818, 0x001E, 0x0000, 0x0000, 0x1818, 0x001E, 0x0000, 0x0000, 0x1818, 0x001E,
                    0x0000, 0x0000, 0x1E18, 0x0000, 0x0000, 0x0000, 0x001E, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x1600, 0x0016, 0x0000, 0x0000, 0x1600, 0x1616, 0x0000, 0x0000,
                    0x1600, 0x1616, 0x0016, 0x0000, 0x0000, 0x1600, 0x1616, 0x0000, 0x0000, 0x0000,
                    0x1616, 0x1416, 0x0000, 0x0000, 0x1600, 0x1314, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x1600, 0x0016, 0x0000, 0x0000,
                    0x1616, 0x0016, 0x0000, 0x1600, 0x1616, 0x0016, 0x0000, 0x1616, 0x0016, 0x0000,
                    0x1614, 0x1616, 0x0000, 0x0000, 0x1413, 0x0016, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x1400, 0x1313, 0x0000, 0x0000, 0x1400, 0x1313, 0x0000, 0x0000, 0x1400, 0x1313,
                    0x0000, 0x0000, 0x1400, 0x1313, 0x0000, 0x0000, 0x0000, 0x1314, 0x0000, 0x0000,
                    0x0000, 0x1400, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x1313, 0x0014, 0x0000, 0x0000, 0x1313, 0x0014, 0x0000, 0x0000, 0x1313, 0x0014,
                    0x0000, 0x0000, 0x1313, 0x0014, 0x0000, 0x0000, 0x1413, 0x0000, 0x0000, 0x0000,
                    0x0014, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x1600, 0x1616, 0x1616, 0x1416,
                    0x1616, 0x1616, 0x1616, 0x1314, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x1614, 0x1616,
                    0x1616, 0x0016, 0x1413, 0x1616, 0x1616, 0x1616, 0x1600, 0x1616, 0x1416, 0x1313,
                    0x0000, 0x0000, 0x1400, 0x1313, 0x0000, 0x0000, 0x1400, 0x1313, 0x0000, 0x0000,
                    0x1400, 0x1313, 0x0000, 0x0000, 0x1400, 0x1313, 0x0000, 0x0000, 0x0000, 0x1314,
                    0x0000, 0x0000, 0x0000, 0x1400, 0x0000, 0x0000, 0x0000, 0x0000, 0x1313, 0x1614,
                    0x1616, 0x0016, 0x1313, 0x0014, 0x0000, 0x0000, 0x1313, 0x0014, 0x0000, 0x0000,
                    0x1313, 0x0014, 0x0000, 0x0000, 0x1313, 0x0014, 0x0000, 0x0000, 0x1413, 0x0000,
                    0x0000, 0x0000, 0x0014, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x4000, 0x0040,
                    0x0000, 0x0000, 0x4000, 0x4040, 0x0000, 0x0000, 0x4000, 0x4040, 0x0040, 0x0000,
                    0x0000, 0x4000, 0x4040, 0x0000, 0x0000, 0x0000, 0x4040, 0x3E40, 0x0000, 0x0000,
                    0x4000, 0x373E, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x4000, 0x0040, 0x0000, 0x0000, 0x4040, 0x0040, 0x0000, 0x4000,
                    0x4040, 0x0040, 0x0000, 0x4040, 0x0040, 0x0000, 0x403E, 0x4040, 0x0000, 0x0000,
                    0x3E37, 0x0040, 0x0000, 0x0000, 0x0000, 0x0000, 0x3E00, 0x3737, 0x0000, 0x0000,
                    0x3E00, 0x3737, 0x0000, 0x0000, 0x3E00, 0x3737, 0x0000, 0x0000, 0x3E00, 0x3737,
                    0x0000, 0x0000, 0x0000, 0x373E, 0x0000, 0x0000, 0x0000, 0x3E00, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x3737, 0x003E, 0x0000, 0x0000,
                    0x3737, 0x003E, 0x0000, 0x0000, 0x3737, 0x003E, 0x0000, 0x0000, 0x3737, 0x003E,
                    0x0000, 0x0000, 0x3E37, 0x0000, 0x0000, 0x0000, 0x003E, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x4000, 0x4040, 0x4040, 0x3E40, 0x4040, 0x4040, 0x4040, 0x373E,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x403E, 0x4040, 0x4040, 0x0040, 0x3E37, 0x4040,
                    0x4040, 0x4040, 0x4000, 0x4040, 0x3E40, 0x3737, 0x0000, 0x0000, 0x3E00, 0x3737,
                    0x0000, 0x0000, 0x3E00, 0x3737, 0x0000, 0x0000, 0x3E00, 0x3737, 0x0000, 0x0000,
                    0x3E00, 0x3737, 0x0000, 0x0000, 0x0000, 0x373E, 0x0000, 0x0000, 0x0000, 0x3E00,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x3737, 0x403E, 0x4040, 0x0040, 0x3737, 0x003E,
                    0x0000, 0x0000, 0x3737, 0x003E, 0x0000, 0x0000, 0x3737, 0x003E, 0x0000, 0x0000,
                    0x3737, 0x003E, 0x0000, 0x0000, 0x3E37, 0x0000, 0x0000, 0x0000, 0x003E, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000};

const unsigned short FliesPalette[256] = {
                    0x0000, 0x0002, 0x043E, 0x0C7A, 0x18D6, 0x1CEC, 0x0853, 0x042F, 0x042A, 0x211E,
                    0x2D7D, 0x463D, 0x5ADD, 0x7426, 0x5CE9, 0x3D09, 0x20A6, 0x5024, 0x2802, 0x750B,
                    0x75D0, 0x7654, 0x76F8, 0x0BA6, 0x16E8, 0x1DE8, 0x1926, 0x06A5, 0x0562, 0x1FAB,
                    0x3FB1, 0x57B6, 0x0BBD, 0x1339, 0x1E10, 0x194A, 0x06B5, 0x01EF, 0x0129, 0x1BBD,
                    0x2FBD, 0x47BD, 0x5BBD, 0x09FC, 0x15D6, 0x1D70, 0x190A, 0x0575, 0x0510, 0x00CB,
                    0x161C, 0x2A7C, 0x3ABD, 0x5B5E, 0x7458, 0x5CD4, 0x40EF, 0x28EA, 0x5432, 0x402D,
                    0x2808, 0x74F9, 0x755A, 0x763B, 0x76DC, 0x6B83, 0x52C6, 0x3E08, 0x2946, 0x4EA2,
                    0x3E01, 0x2D81, 0x6FA9, 0x6FAE, 0x73B3, 0x77B8, 0x294A, 0x4A52, 0x6B5A, 0x7FFF,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
                    0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000};
