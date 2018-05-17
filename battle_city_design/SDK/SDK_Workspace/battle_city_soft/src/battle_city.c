
#include <stdint.h>
#include "battle_city.h"
#include "map.h"
#include "xparameters.h"
#include "xil_io.h"
#include "xio.h"
//#include <unistd.h>

/*
* GENERATED BY BC_MEM_PACKER
* DATE: Wed Jul 08 21:00:48 2015
*/

//map_entry_t* mape;

// ***** 8x8 IMAGES *****

#define IMG_8x8_01_A                    0x0100
#define IMG_8x8_02_B                    0x0110
#define IMG_8x8_03_V                    0x0120
#define IMG_8x8_04_G                    0x0130
#define IMG_8x8_05_D                    0x0140
#define IMG_8x8_06_DJ                   0x0150
#define IMG_8x8_07_E                    0x0160
#define IMG_8x8_08_ZH                   0x0170
#define IMG_8x8_09_Z                    0x0180
#define IMG_8x8_10_I                    0x0190
#define IMG_8x8_11_J                    0x01A0
#define IMG_8x8_12_K                    0x01B0
#define IMG_8x8_13_L                    0x01C0
#define IMG_8x8_14_LJ                   0x01D0
#define IMG_8x8_15_M                    0x01E0
#define IMG_8x8_16_N                    0x01F0
#define IMG_8x8_17_NJ                   0x0200
#define IMG_8x8_18_O                    0x0210
#define IMG_8x8_19_P                    0x0220
#define IMG_8x8_20_R                    0x0230
#define IMG_8x8_21_S                    0x0240
#define IMG_8x8_22_T                    0x0250
#define IMG_8x8_23_TJ                   0x0260
#define IMG_8x8_24_U                    0x0270
#define IMG_8x8_25_F                    0x0280
#define IMG_8x8_26_H                    0x0290
#define IMG_8x8_27_C                    0x02A0
#define IMG_8x8_28_CH                   0x02B0
#define IMG_8x8_29_DZH                  0x02C0
#define IMG_8x8_30_SH                   0x02D0
#define IMG_8x8_31_NUM_0                0x02E0
#define IMG_8x8_32_NUM_1                0x02F0
#define IMG_8x8_33_NUM_2                0x0300
#define IMG_8x8_34_NUM_3                0x0310
#define IMG_8x8_35_NUM_4                0x0320
#define IMG_8x8_36_NUM_5                0x0330
#define IMG_8x8_37_NUM_6                0x0340
#define IMG_8x8_38_NUM_7                0x0350
#define IMG_8x8_39_NUM_8                0x0360
#define IMG_8x8_40_NUM_9                0x0370
#define IMG_8x8_41_DOTS                 0x0380
#define IMG_8x8_42_FULLSTOP             0x0390
#define IMG_8x8_BLANK                   0x03A0
#define IMG_8x8_BRICK                   0x03B0
#define IMG_8x8_GRASS                   0x03C0
#define IMG_8x8_ICE                     0x03D0
#define IMG_8x8_IRON                    0x03E0
#define IMG_8x8_LIVES_REMAINING_ICON    0x03F0
#define IMG_8x8_NULL                    0x0400
#define IMG_8x8_TANKS_REMAINING_ICON    0x0410
#define IMG_8x8_WATER                   0x0420


// ***** 16x16 IMAGES *****

#define IMG_16x16_BASE_ALIVE            0x0430
#define IMG_16x16_BASE_DEAD             0x0470
#define IMG_16x16_BONUS_BOMB            0x04B0
#define IMG_16x16_BONUS_GUN             0x04F0
#define IMG_16x16_BONUS_SHELL           0x0530
#define IMG_16x16_BONUS_SHOVEL          0x0570
#define IMG_16x16_BONUS_STAR            0x05B0
#define IMG_16x16_BONUS_TANK            0x05F0
#define IMG_16x16_BONUS_TIME            0x0630
#define IMG_16x16_BULLET                0x0670
#define IMG_16x16_ENEMY_TANK1           0x06B0
#define IMG_16x16_ENEMY_TANK2           0x06F0
#define IMG_16x16_ENEMY_TANK3           0x0730
#define IMG_16x16_ENEMY_TANK4           0x0770
#define IMG_16x16_EXPLOSION             0x07B0
#define IMG_16x16_FLAG                  0x07F0
#define IMG_16x16_MAIN_TANK             0x0830


// ***** MAP *****

#define MAP_BASE_ADDRESS                0x0870
#define MAP_X							8
#define MAP_Y							4
#define MAP_W							26
#define MAP_H							26

#define REGS_BASE_ADDRESS               ( MAP_BASE_ADDRESS + MAP_WIDTH * MAP_HEIGHT )
#define REGS_BASE_ADDRESS2               ( MAP_BASE_ADDRESS + MAP_WIDTH * MAP_HEIGHT)


#define BTN_DOWN( b )                   ( !( b & 0x01 ) )
#define BTN_UP( b )                     ( !( b & 0x10 ) )
#define BTN_LEFT( b )                   ( !( b & 0x02 ) )
#define BTN_RIGHT( b )                  ( !( b & 0x08 ) )
#define BTN_SHOOT( b )                  ( !( b & 0x04 ) )


#define TANK1_REG_L                     8
#define TANK1_REG_H                     9
#define BULLET1_REG_L                   6
#define BULLET1_REG_H                   7
#define TANK_AI_REG_L                   4
#define TANK_AI_REG_H                   5
#define TANK_AI2_REG_L                  12
#define TANK_AI2_REG_H                  13
#define BULLET_AI_REG_L                 2
#define BULLET_AI_REG_H                 3
#define BULLET_AI2_REG_L                10
#define BULLET_AI2_REG_H                11
#define BASE_REG_L						0
#define BASE_REG_H						1

typedef enum {
	BASE = 0,
	TANK0,
	BULLET,
	ENEMY0,
	ENEMY1,
	ENEMY2,
	ENEMY3,
	ENEMY4
} sprite_reg_id_t;

#define BULLET_STEP_DURATION            5
#define BULLET_EXPLOSION_DURATION       5

#define BASE_X		                    159	//311
#define BASE_Y						    279	//463


typedef enum {
    _TERM       = 0,
    _A          = IMG_8x8_01_A,
    _B          = IMG_8x8_02_B,
    _V          = IMG_8x8_03_V,
    _G          = IMG_8x8_04_G,
    _D          = IMG_8x8_05_D,
    _DJ         = IMG_8x8_06_DJ,
    _E          = IMG_8x8_07_E,
    _ZH         = IMG_8x8_08_ZH,
    _Z          = IMG_8x8_09_Z,
    _I          = IMG_8x8_10_I,
    _J          = IMG_8x8_11_J,
    _K          = IMG_8x8_12_K,
    _L          = IMG_8x8_13_L,
    _LJ         = IMG_8x8_14_LJ,
    _M          = IMG_8x8_15_M,
    _N          = IMG_8x8_16_N,
    _NJ         = IMG_8x8_17_NJ,
    _O          = IMG_8x8_18_O,
    _P          = IMG_8x8_19_P,
    _R          = IMG_8x8_20_R,
    _S          = IMG_8x8_21_S,
    _T          = IMG_8x8_22_T,
    _TJ         = IMG_8x8_23_TJ,
    _U          = IMG_8x8_24_U,
    _F          = IMG_8x8_25_F,
    _H          = IMG_8x8_26_H,
    _C          = IMG_8x8_27_C,
    _CH         = IMG_8x8_28_CH,
    _DZH        = IMG_8x8_29_DZH,
    _SH         = IMG_8x8_30_SH,
    _0          = IMG_8x8_31_NUM_0,
    _1          = IMG_8x8_32_NUM_1,
    _2          = IMG_8x8_33_NUM_2,
    _3          = IMG_8x8_34_NUM_3,
    _4          = IMG_8x8_35_NUM_4,
    _5          = IMG_8x8_36_NUM_5,
    _6          = IMG_8x8_37_NUM_6,
    _7          = IMG_8x8_38_NUM_7,
    _8          = IMG_8x8_39_NUM_8,
    _9          = IMG_8x8_40_NUM_9,
    _DOTS       = IMG_8x8_41_DOTS,
    _FULLSTOP   = IMG_8x8_42_FULLSTOP,
    _SPACE      = IMG_8x8_BLANK
} characters_t;

typedef enum {
	RES_NONE,
	RES_VICTORY,
	RES_LOSS
} game_result_t;

typedef enum {
    b_false,
    b_true
} bool_t;

typedef enum {
	DIR_UP,
	DIR_LEFT,
	DIR_DOWN,
	DIR_RIGHT

} direction_t;

typedef struct {
    unsigned int    x;
    unsigned int    y;
    direction_t     dir;

    bool_t          enabled;
    unsigned int    time;
    bool_t          explosion;

    unsigned int    reg_l;
    unsigned int    reg_h;
} bullet_t;

typedef struct {
    unsigned int    x;
    unsigned int    y;
    direction_t     dir;
    unsigned int    type;

    bool_t          destroyed;

    bullet_t        bullet;

    unsigned int    reg_l;
    unsigned int    reg_h;
} tank_t;


tank_t tank1 = {
    ( MAP_X + MAP_W / 2 +2) * 8,	// x
    ( MAP_Y+2 + MAP_H - 5 ) * 8,	// y
    DIR_UP,              			// dir
    IMG_16x16_MAIN_TANK,  			// type

    b_false,                		// destroyed

    {
        0,                  		// bullet.x
        0,                  		// bullet.y
        DIR_RIGHT,           		// bullet.dir

        b_false,            		// bullet.enabled
        0,                  		// bullet.time
        b_false,            		// bullet.explosion

        BULLET1_REG_L,      		// bullet.reg_l
        BULLET1_REG_H       		// bullet.reg_h


    },

    TANK1_REG_L,
    TANK1_REG_H
};


tank_t tank_ai = {
    MAP_X * 8,						// x
    MAP_Y * 8,						// y
    DIR_RIGHT,              		// dir
    IMG_16x16_ENEMY_TANK3,  		// type

    b_false,                		// destroyed

    {
        0,                  		// bullet.x
        0,                  		// bullet.y
        DIR_RIGHT,           		// bullet.dir

        b_false,            		// bullet.enabled
        0,                  		// bullet.time
        b_false,            		// bullet.explosion

        BULLET_AI_REG_L,      		// bullet.reg_l
        BULLET_AI_REG_H       		// bullet.reg_h
    },


    TANK_AI_REG_L,
    TANK_AI_REG_H
};


tank_t tank_ai2 = {
  ( MAP_X +20) * 8,					// x
  ( MAP_Y ) * 8,					// y
    DIR_LEFT,              			// dir
    IMG_16x16_ENEMY_TANK4,  		// type

    b_false,                		// destroyed

    {
        0,                  		// bullet.x
        0,                  		// bullet.y
        DIR_RIGHT,           		// bullet.dir

        b_false,            		// bullet.enabled
        0,                  		// bullet.time
        b_false,            		// bullet.explosion

        BULLET_AI2_REG_L,      		// bullet.reg_l
        BULLET_AI2_REG_H       		// bullet.reg_h
    },

    TANK_AI2_REG_L,
    TANK_AI2_REG_H
};


//ovo bi trebalo da radi
static void tenkzi_spawn(tank_t * tenkzi) {
	Xil_Out32(
			XPAR_BATTLE_CITY_PERIPH_0_BASEADDR + 4 * ( REGS_BASE_ADDRESS + tenkzi->reg_l ),
			(u32 )0x8F000000 | ( tenkzi->dir << 16 ) | (u32 )tenkzi->type);
	Xil_Out32(
			XPAR_BATTLE_CITY_PERIPH_0_BASEADDR + 4 * ( REGS_BASE_ADDRESS + tenkzi->reg_h ),
			(tenkzi->y << 16) | tenkzi->x);
}


unsigned int	game_time;
unsigned char	game_result;

//radi
unsigned int rand_lfsr113( void )
{
	static unsigned int z1 = 12345, z2 = 12345, z3 = 12345, z4 = 12345;
	unsigned int b;

	b  = ( ( z1 << 6 ) ^ z1 ) >> 13;
	z1 = ( ( z1 & 4294967294U ) << 18 ) ^ b;
	b  = ( ( z2 << 2 ) ^ z2 ) >> 27;
	z2 = ( ( z2 & 4294967288U ) << 2) ^ b;
	b  = ( ( z3 << 13) ^ z3 ) >> 21;
	z3 = ( ( z3 & 4294967280U ) << 7 ) ^ b;
	b  = ( ( z4 << 3 ) ^ z4 ) >> 12;
	z4 = ( ( z4 & 4294967168U ) << 13 ) ^ b;

	return ( z1 ^ z2 ^ z3 ^ z4 );
}
//radi
static void draw_string( unsigned int x, unsigned int y, unsigned int * text )
{
    int i;
    
    i = 0;

    while( text[ i ] != _TERM ) {
        Xil_Out32( XPAR_BATTLE_CITY_PERIPH_0_BASEADDR + 4 * ( MAP_BASE_ADDRESS + y * MAP_WIDTH + x + i ), text[ i ] );
        i++;
    }
}
//radi
static void map_update( map_entry_t * map )
{
    unsigned int i;

    for( i = 0; i < MAP_WIDTH * MAP_HEIGHT; i++ ) {
        if( map[ i ].update ) {
            map[ i ].update = 0;

            Xil_Out32( XPAR_BATTLE_CITY_PERIPH_0_BASEADDR + 4 * ( MAP_BASE_ADDRESS + i ), ( (unsigned int)map[ i ].z << 16 ) | ( (unsigned int)map[ i ].rot << 16 ) | (unsigned int)map[ i ].ptr );
        }
    }
}
//radi
static void map_reset( map_entry_t * map )
{
    unsigned int i;

    for( i = 0; i < MAP_WIDTH * MAP_HEIGHT; i++ ) {
        Xil_Out32( XPAR_BATTLE_CITY_PERIPH_0_BASEADDR + 4 * ( MAP_BASE_ADDRESS + i ), ( (unsigned int)map[ i ].z << 16 ) | ( (unsigned int)map[ i ].rot << 16 ) | (unsigned int)map[ i ].ptr );
    }

    for( i = 0; i <= 20; i += 2 ) {
    	Xil_Out32( XPAR_BATTLE_CITY_PERIPH_0_BASEADDR + 4 * ( REGS_BASE_ADDRESS + i ), (unsigned int)0x0F000000 );
    }
}

//poziva tenkzi i radi
static void tank_spawn( tank_t * tank )
{
	tenkzi_spawn(tank);
}
//
//relativno radi
static bool_t hitbox( unsigned int x1, unsigned int y1, unsigned int x2, unsigned int y2, unsigned int w, unsigned int h , direction_t dir)
{

	if(dir==DIR_UP){
		return ( x1 >= x2 - 16 && x1 <= x2 +8 && y1 >= y2-8 && y1 <= y2 + h ) ? b_true : b_false;
	} else if(dir==DIR_DOWN){
		return ( x1 >= x2 - 16  && x1 <= x2 +8 && y1 >= y2 -h && y1 <= y2 +8 ) ? b_true : b_false;
	} else if(dir==DIR_LEFT){
		return ( x1 >= x2 - 16 && x1 <= x2 +8 && y1 >= y2 -8 && y1 <= y2 + h ) ? b_true : b_false;
	} else if(dir==DIR_RIGHT){
		return ( x1 >= x2 - 16 && x1 <= x2 +8 && y1 >= y2 -8 && y1 <= y2 + h ) ? b_true : b_false;
	}

}

static direction_t change_dir(direction_t dir){
	direction_t dir_new;
	if (dir==DIR_DOWN){
		dir_new=DIR_UP;
	} else if (dir==DIR_UP){
		dir_new=DIR_DOWN;
	} else if (dir==DIR_RIGHT){
		dir_new=DIR_LEFT;
	} else{
		dir_new=DIR_RIGHT;
	}
	return dir_new;
}

static bool_t tank_move( map_entry_t * map, tank_t * tank,tank_t * tank1,tank_t * tank2, direction_t dir )
{
	tank->dir = dir;
	tenkzi_spawn(tank);


    unsigned int    x;
    unsigned int    y;
    map_entry_t *   tl;
    map_entry_t *   tc;
    map_entry_t *   tr;
    map_entry_t *   cl;
	map_entry_t *   cc;
	map_entry_t *   cr;
	map_entry_t *   bl;
	map_entry_t *   bc;
	map_entry_t *   br;

    if( tank->x > ( MAP_X + MAP_W ) * 8 - 16 ||
        tank->y > ( MAP_Y + MAP_H ) * 8 - 16 ) {
        return b_false;
    }

    x = tank->x;
    y = tank->y;

    // Make sure that coordinates will stay within map boundaries after moving.
    if( dir == DIR_LEFT ) {
        if( x > MAP_X * 8 )
        	x--;
    } else if( dir == DIR_RIGHT ) {
        if( x < ( MAP_X + MAP_W ) * 8 - 16 )
        	x++;
    } else if( dir == DIR_UP ) {
        if( y > MAP_Y * 8 )
            y--;
    } else if( dir == DIR_DOWN ) {
        if( y < ( MAP_Y + MAP_H ) * 8 - 16 )
        	y++;
    }

    tl = &map[ ( y / 8 ) * MAP_WIDTH + ( x / 8 ) ];
	tc = &map[ ( y / 8 ) * MAP_WIDTH + ( ( x + 7 ) / 8 ) ];
	tr = &map[ ( y / 8 ) * MAP_WIDTH + ( ( x + 15 ) / 8 ) ];
	cl = &map[ ( ( y + 7 ) / 8 ) * MAP_WIDTH + ( x / 8 ) ];
	cc = &map[ ( ( y + 7 ) / 8 ) * MAP_WIDTH + ( ( x + 7 ) / 8 ) ];
	cr = &map[ ( ( y + 7 ) / 8 ) * MAP_WIDTH + ( ( x + 15 ) / 8 ) ];
	bl = &map[ ( ( y + 15 ) / 8 ) * MAP_WIDTH + ( x / 8 ) ];
	bc = &map[ ( ( y + 15 ) / 8 ) * MAP_WIDTH + ( ( x + 7 ) / 8 ) ];
	br = &map[ ( ( y + 15 ) / 8 ) * MAP_WIDTH + ( ( x + 15 ) / 8 ) ];

    if( tank->x != x || tank->y != y ) {
        // Tank can move if water, iron or brick wall isn't ahead.
        if( tl->ptr != IMG_8x8_BRICK && tl->ptr != IMG_8x8_IRON && tl->ptr != IMG_8x8_WATER &&
			tc->ptr != IMG_8x8_BRICK && tl->ptr != IMG_8x8_IRON && tl->ptr != IMG_8x8_WATER &&
			tr->ptr != IMG_8x8_BRICK && tl->ptr != IMG_8x8_IRON && tl->ptr != IMG_8x8_WATER &&
			cl->ptr != IMG_8x8_BRICK && tl->ptr != IMG_8x8_IRON && tl->ptr != IMG_8x8_WATER &&
			cc->ptr != IMG_8x8_BRICK && tl->ptr != IMG_8x8_IRON && tl->ptr != IMG_8x8_WATER &&
			cr->ptr != IMG_8x8_BRICK && tl->ptr != IMG_8x8_IRON && tl->ptr != IMG_8x8_WATER &&
        	bl->ptr != IMG_8x8_BRICK && tr->ptr != IMG_8x8_IRON && tr->ptr != IMG_8x8_WATER &&
        	bc->ptr != IMG_8x8_BRICK && bl->ptr != IMG_8x8_IRON && bl->ptr != IMG_8x8_WATER &&
        	br->ptr != IMG_8x8_BRICK && br->ptr != IMG_8x8_IRON && br->ptr != IMG_8x8_WATER)
        {

        	//if(hitbox(x, y, tank1->x, tank1->y, 16, 16, tank1->dir) ==b_false){

        	//if(hitbox(x, y, tank2->x, tank2->y, 16, 16, tank2->dir) ==b_false){


        			tank->x = x;
        			tank->y = y;
        			tank->dir = dir;

        			tenkzi_spawn(tank);



        			return b_true;
        	//}
       // }
        }
    }

    return b_false;
}


static void tank_fire( map_entry_t * map, tank_t * tank )
{
    bullet_t * blt;

    if( tank->bullet.enabled ) {
    	return;
    }

    blt = 0;

    if( tank->dir == DIR_LEFT ) {
        if( tank->x > MAP_X * 8 - 16 ) {
            blt = &tank->bullet;

            blt->x = tank->x - 8;
            blt->y = tank->y;
        }
    } else if( tank->dir == DIR_RIGHT ) {
        if( tank->x < ( MAP_X + MAP_W ) * 8 - 16 ) {
            blt = &tank->bullet;

            blt->x = tank->x + 8;
            blt->y = tank->y;
        }
    } else if( tank->dir == DIR_UP ) {
        if( tank->y > MAP_Y * 8 + 16 ) {
            blt = &tank->bullet;

            blt->x = tank->x;
            blt->y = tank->y - 8;
        }
    } else if( tank->dir == DIR_DOWN ) {
        if( tank->y < ( MAP_Y + MAP_H ) * 8 - 16 ) {
            blt = &tank->bullet;

            blt->x = tank->x;
            blt->y = tank->y + 8;
        }
    }

    if( blt ) {
    	blt->enabled = b_true;
        blt->dir = tank->dir;
        blt->explosion = b_false;
        blt->time = game_time;

        Xil_Out32( XPAR_BATTLE_CITY_PERIPH_0_BASEADDR + 4 * ( REGS_BASE_ADDRESS + blt->reg_l  ), (unsigned int)0x8F000000 | ( (unsigned int)blt->dir << 16 ) | (unsigned int)IMG_16x16_BULLET );
        Xil_Out32( XPAR_BATTLE_CITY_PERIPH_0_BASEADDR + 4 * ( REGS_BASE_ADDRESS + blt->reg_h ), ( blt->y << 16 ) | blt->x );
    }
}




static void process_bullet( map_entry_t * map, bullet_t * blt )
{
    unsigned int    x;
    unsigned int    y;
    map_entry_t *   tl;
    map_entry_t *   tr;
   	map_entry_t *   bl;
   	map_entry_t *   br;


	if( !blt->enabled ) {
		return;
	}

    if( blt->explosion ) {
        if( game_time > blt->time + BULLET_EXPLOSION_DURATION ) {
            blt->enabled = b_false;
            Xil_Out32( XPAR_BATTLE_CITY_PERIPH_0_BASEADDR + 4 * ( REGS_BASE_ADDRESS + blt->reg_l ), 0x0F000000 );
        }
    } else {
        if( game_time > blt->time + BULLET_STEP_DURATION ) {
            blt->time = game_time;

            x = blt->x;
            y = blt->y;

            // Make sure that coordinates will stay within map boundaries after moving.
            if( blt->dir == DIR_LEFT ) {
                if( x > MAP_X * 8 )
                    x--;
            } else if( blt->dir == DIR_RIGHT ) {
                if( x < ( MAP_X + MAP_W ) * 8 - 16 )
                    x++;
            } else if( blt->dir == DIR_UP ) {
                if( y > MAP_Y * 8 )
                    y--;
            } else if( blt->dir == DIR_DOWN ) {
                if( y < ( MAP_Y + MAP_H ) * 8 - 16 )
                    y++;
            }

            tl = &map[ ( ( y + 4 ) / 8 ) * MAP_WIDTH + ( ( x + 4 ) / 8 ) ];
			tr = &map[ ( ( y + 4 ) / 8 ) * MAP_WIDTH + ( ( x + 11 ) / 8 ) ];
			bl = &map[ ( ( y + 11 ) / 8 ) * MAP_WIDTH + ( ( x + 4 ) / 8 ) ];
			br = &map[ ( ( y + 11 ) / 8 ) * MAP_WIDTH + ( ( x + 11 ) / 8 ) ];/////menjano sa 15

            if( blt->x != x || blt->y != y ) {
            	if( blt == &tank1.bullet ) {
					if( hitbox( x, y, tank_ai2.x, tank_ai2.y, 16, 16, blt->dir ) == b_true ) {
						game_result = RES_VICTORY;
						return;
					} else if ( hitbox( x, y, tank_ai.x, tank_ai.y, 16, 16 ,blt->dir) == b_true ) {
						game_result = RES_VICTORY;
						return;
					} else if ( hitbox( x, y, BASE_X, BASE_Y, 16, 16,blt->dir ) == b_true ) {
						game_result = RES_LOSS;
						return;
					}
            	} else {
					if( hitbox( x, y, tank1.x, tank1.y, 16, 16,blt->dir ) == b_true ) {
						game_result = RES_LOSS;
						return;
					}
            	}

                if( tl->ptr == IMG_8x8_BRICK || tl->ptr == IMG_8x8_IRON ) {
                	if( tl->ptr == IMG_8x8_BRICK ) {
                		tl->ptr = IMG_8x8_NULL;
                    	tl->update = b_true;
                    	if( tr->ptr == IMG_8x8_BRICK ) {
                    	                		tr->ptr = IMG_8x8_NULL;
                    	                    	tr->update = b_true;
                    	                	}
                    	if( bl->ptr == IMG_8x8_BRICK ) {
                    	                    	                		bl->ptr = IMG_8x8_NULL;
                    	                    	                    	bl->update = b_true;
                    	                    	                	}


                	}

                    blt->explosion = b_true;
                    blt->time = game_time;

                    Xil_Out32( XPAR_BATTLE_CITY_PERIPH_0_BASEADDR + 4 * ( REGS_BASE_ADDRESS + blt->reg_l ), (unsigned int)0x8F000000 | (unsigned int)IMG_16x16_EXPLOSION );
                    Xil_Out32( XPAR_BATTLE_CITY_PERIPH_0_BASEADDR + 4 * ( REGS_BASE_ADDRESS + blt->reg_h ), ( blt->y << 16 ) | blt->x);
                } else if( tr->ptr == IMG_8x8_BRICK || tr->ptr == IMG_8x8_IRON ) {
                	if( tr->ptr == IMG_8x8_BRICK ) {
                		tr->ptr = IMG_8x8_NULL;
                    	tr->update = b_true;
                    	if( tl->ptr == IMG_8x8_BRICK ) {
                    	                		tl->ptr = IMG_8x8_NULL;
                    	                    	tl->update = b_true;
                    	                	}
                    	if( br->ptr == IMG_8x8_BRICK ) {
                    	                    	                		br->ptr = IMG_8x8_NULL;
                    	                    	                    	br->update = b_true;
                    	                    	                	}
                	}

                    blt->explosion = b_true;
                    blt->time = game_time;

                    Xil_Out32( XPAR_BATTLE_CITY_PERIPH_0_BASEADDR + 4 * ( REGS_BASE_ADDRESS + blt->reg_l ), (unsigned int)0x8F000000 | (unsigned int)IMG_16x16_EXPLOSION );
                    Xil_Out32( XPAR_BATTLE_CITY_PERIPH_0_BASEADDR + 4 * ( REGS_BASE_ADDRESS + blt->reg_h ), ( blt->y << 16 ) | blt->x );
                } else if( bl->ptr == IMG_8x8_BRICK || bl->ptr == IMG_8x8_IRON ) {
                	if( bl->ptr == IMG_8x8_BRICK ) {
                		bl->ptr = IMG_8x8_NULL;
                    	bl->update = b_true;
                    	if( br->ptr == IMG_8x8_BRICK ) {
                    	                		br->ptr = IMG_8x8_NULL;
                    	                    	br->update = b_true;
                    	                	}
                    	if( tl->ptr == IMG_8x8_BRICK ) {
                    	                    	                		tl->ptr = IMG_8x8_NULL;
                    	                    	                    	tl->update = b_true;
                    	                    	                	}
                	}

                    blt->explosion = b_true;
                    blt->time = game_time;

                    Xil_Out32( XPAR_BATTLE_CITY_PERIPH_0_BASEADDR + 4 * ( REGS_BASE_ADDRESS + blt->reg_l ), (unsigned int)0x8F000000 | (unsigned int)IMG_16x16_EXPLOSION );
                    Xil_Out32( XPAR_BATTLE_CITY_PERIPH_0_BASEADDR + 4 * ( REGS_BASE_ADDRESS + blt->reg_h ), ( blt->y << 16 ) | blt->x);
                } else if( br->ptr == IMG_8x8_BRICK || br->ptr == IMG_8x8_IRON ) {
                	if( br->ptr == IMG_8x8_BRICK ) {
                		br->ptr = IMG_8x8_NULL;
                    	br->update = b_true;
                    	if( bl->ptr == IMG_8x8_BRICK ) {
                    	                		bl->ptr = IMG_8x8_NULL;
                    	                    	bl->update = b_true;
                    	                	}
                    	if( tl->ptr == IMG_8x8_BRICK ) {
                    	                    	                    	                		tl->ptr = IMG_8x8_NULL;
                    	                    	                    	                    	tl->update = b_true;
                    	                    	                    	                	}
                	}

                    blt->explosion = b_true;
                    blt->time = game_time;

                    Xil_Out32( XPAR_BATTLE_CITY_PERIPH_0_BASEADDR + 4 * ( REGS_BASE_ADDRESS + blt->reg_l ), (unsigned int)0x8F000000 | (unsigned int)IMG_16x16_EXPLOSION );
                    Xil_Out32( XPAR_BATTLE_CITY_PERIPH_0_BASEADDR + 4 * ( REGS_BASE_ADDRESS + blt->reg_h ), ( blt->y << 16 ) | blt->x );
                }
                 else {
                    blt->x = x;
                    blt->y = y;

                    Xil_Out32( XPAR_BATTLE_CITY_PERIPH_0_BASEADDR + 4 * ( REGS_BASE_ADDRESS + blt->reg_h ), ( blt->y << 16 ) | blt->x);
                }
            } else {
                blt->enabled = b_false;
                Xil_Out32( XPAR_BATTLE_CITY_PERIPH_0_BASEADDR + 4 * ( REGS_BASE_ADDRESS + blt->reg_l ), 0x0F000000 );
            }
        }
    }
}


static void process_ai( tank_t * tank,tank_t * tank3, unsigned int * ai_dir )
{
	unsigned int	tmp_dir;
	bool_t			turn;
	bool_t			fire;
	unsigned int	i;

	if( game_time % 111 == 0 )
			fire = b_true;

	if( game_time % 300 == 0 ) {
		turn = b_true;
	} else {
		turn = b_false;
	}

	if( turn == b_true ) {
		do {
			while( tmp_dir == *ai_dir ) {
				tmp_dir = rand_lfsr113( ) % 4;
			}

			*ai_dir = tmp_dir;
		} while( tank_move( mape, &tank_ai, &tank_ai2, &tank1, *ai_dir ) == b_false );
	} else {
		//return;
		while( tank_move( mape, &tank_ai, &tank_ai2, &tank1, *ai_dir ) == b_false ) {
			while( tmp_dir == *ai_dir ) {
				tmp_dir = rand_lfsr113( ) % 4;
			}

			*ai_dir = tmp_dir;
		}
	}

	i = 0;


	/*if( *ai_dir == DIR_DOWN ) {
		while( tank->y / 8 + i < MAP_Y + MAP_H) {   //////
			if( mape[ ( tank->y / 8 + i ) * MAP_WIDTH + tank->x / 8 ].ptr == IMG_8x8_BRICK ||
				mape[ ( tank->y / 8 + i ) * MAP_WIDTH + tank->x / 8 ].ptr == IMG_8x8_IRON ) {
				break;
			} else if( hitbox( tank->x, tank->y + i * 8, tank1.x, tank1.y, 16, 16, tmp_dir ) == b_true ) {
				fire = b_true;
				break;
			}

			i++;
		}
	} else if( *ai_dir == DIR_UP ) {
		while( tank->y / 8 - i > MAP_Y ) {
			if( mape[ ( tank->y / 8 - i ) * MAP_WIDTH + tank->x / 8 ].ptr == IMG_8x8_BRICK ||
				mape[ ( tank->y / 8 - i ) * MAP_WIDTH + tank->x / 8 ].ptr == IMG_8x8_IRON ) {
				fire = b_false;///
				break;
			} else if( hitbox( tank->x, tank->y - i * 8, tank1.x, tank1.y, 16, 16, tmp_dir ) == b_true ) {
				fire = b_true;
				break;
			}

			i++;
		}
	}  else if( *ai_dir == DIR_RIGHT ) {
		while( tank->x / 8 + i < MAP_X + MAP_W ) {
			if( mape[ ( tank->y / 8 ) * MAP_WIDTH + tank->x / 8 + i ].ptr == IMG_8x8_BRICK ||
				mape[ ( tank->y / 8 ) * MAP_WIDTH + tank->x / 8 + i ].ptr == IMG_8x8_IRON ) {
				break;
			} else if( hitbox( tank->x + i * 8, tank->y, tank1.x, tank1.y, 16, 16, tmp_dir ) == b_true ) {
				fire = b_true;
				break;
			}

			i++;
		}
	} else if( *ai_dir == DIR_LEFT ) {
		while( tank->x / 8 - i > MAP_X ) {
			if( mape[ ( tank->y / 8 ) * MAP_WIDTH + tank->x / 8 - 1 ].ptr == IMG_8x8_BRICK ||
				mape[ ( tank->y / 8 ) * MAP_WIDTH + tank->x / 8 - 1 ].ptr == IMG_8x8_IRON ) {
				break;
			} else if( hitbox( tank->x - i * 8, tank->y, tank1.x, tank1.y, 16, 16, tmp_dir ) == b_true ) {
				fire = b_true;
				break;
			}

			i++;
		}
	}
*/
	if( fire == b_true ) {
		tank_fire( mape, tank );
	}
}




static void process_ai2( tank_t * tank, unsigned int * ai_dir2 )
{
	unsigned int	tmp_dir;
	bool_t			turn;
	bool_t			fire;
	unsigned int	i;

	if( game_time % 111 == 0 )
				fire = b_true;

	if( game_time % 300 == 0 ) {
		turn = b_true;
	} else {
		turn = b_false;
	}

	if( turn == b_true ) {
		do {
			while( tmp_dir == *ai_dir2 ) {
				tmp_dir = rand_lfsr113( ) % 4;
			}

			*ai_dir2 = tmp_dir;
		} while( tank_move( mape, &tank_ai2, &tank_ai, &tank1, *ai_dir2 ) == b_false );
	} else {
		while( tank_move( mape, &tank_ai2, &tank_ai, &tank1, *ai_dir2 ) == b_false ) {
			while( tmp_dir == *ai_dir2 ) {
				tmp_dir = rand_lfsr113( ) % 4;
			}

			*ai_dir2 = tmp_dir;
		}
	}

	i = 0;
	//fire = b_false;

	if( *ai_dir2 == DIR_DOWN ) {
		while( tank->y / 8 + i < MAP_Y + MAP_H ) {
			if( mape[ ( tank->y / 8 + i ) * MAP_WIDTH + tank->x / 8 ].ptr == IMG_8x8_BRICK ||
				mape[ ( tank->y / 8 + i ) * MAP_WIDTH + tank->x / 8 ].ptr == IMG_8x8_IRON ) {
				break;
			} else if( hitbox( tank->x, tank->y + i * 8, tank1.x, tank1.y, 16, 16 , tmp_dir) == b_true ) {
				fire = b_true;
				break;
			}

			i++;
		}
	} else if( *ai_dir2 == DIR_UP ) {
		while( tank->y / 8 - i > MAP_Y ) {
			if( mape[ ( tank->y / 8 - i ) * MAP_WIDTH + tank->x / 8 ].ptr == IMG_8x8_BRICK ||
				mape[ ( tank->y / 8 - i ) * MAP_WIDTH + tank->x / 8 ].ptr == IMG_8x8_IRON ) {
				fire = b_false;
				break;
			} else if( hitbox( tank->x, tank->y - i * 8, tank1.x, tank1.y, 16, 16, tmp_dir ) == b_true ) {
				fire = b_true;
				break;
			}

			i++;
		}
	}  else if( *ai_dir2 == DIR_RIGHT ) {
		while( tank->x / 8 + i < MAP_X + MAP_W ) {
			if( mape[ ( tank->y / 8 ) * MAP_WIDTH + tank->x / 8 + i ].ptr == IMG_8x8_BRICK ||
				mape[ ( tank->y / 8 ) * MAP_WIDTH + tank->x / 8 + i ].ptr == IMG_8x8_IRON ) {
				break;
			} else if( hitbox( tank->x + i * 8, tank->y, tank1.x, tank1.y, 16, 16, tmp_dir ) == b_true ) {
				fire = b_true;
				break;
			}

			i++;
		}
	} else if( *ai_dir2 == DIR_LEFT ) {
		while( tank->x / 8 - i > MAP_X ) {
			if( mape[ ( tank->y / 8 ) * MAP_WIDTH + tank->x / 8 - 1 ].ptr == IMG_8x8_BRICK ||
				mape[ ( tank->y / 8 ) * MAP_WIDTH + tank->x / 8 - 1 ].ptr == IMG_8x8_IRON ) {
				break;
			} else if( hitbox( tank->x - i * 8, tank->y, tank1.x, tank1.y, 16, 16, tmp_dir ) == b_true ) {
				fire = b_true;
				break;
			}

			i++;
		}
	}

	if( fire == b_true ) {
		tank_fire( mape, tank );
	}
}





//ne dirati
static void base_spawn( void )
{
	Xil_Out32( XPAR_BATTLE_CITY_PERIPH_0_BASEADDR + 4 * ( REGS_BASE_ADDRESS + BASE_REG_L ), (unsigned int)0x8F000000 | ( (unsigned int)DIR_UP << 16 ) | (unsigned int)IMG_16x16_BASE_ALIVE );
	Xil_Out32( XPAR_BATTLE_CITY_PERIPH_0_BASEADDR + 4 * ( REGS_BASE_ADDRESS + BASE_REG_H ), ( (unsigned int)( (( MAP_Y + MAP_H - 2 ) * 8 ) << 16)  ) | (unsigned int)( ( MAP_X + MAP_W / 2 - 1 ) * 8  ));
}
//ne dirati
void konverzija(map_entry_t *mapa, uint8_t *map){
	//int i,j,k;
	int i; // za gornji deo
	for(i = 0; i <= 320; i++)
	{
		mapa[i].z = 0;
		mapa[i].rot = 0;
		mapa[i].ptr = 0x03A0;
		mapa[i].update = 0;

	}

	int j; // za levi deo ekrana

	i = 0;
	int step = 80;
	while(i<27){
		for(j = 320 +i*step; j <= 327 +i*step; j++)
		{
			mapa[j].z = 0;
			mapa[j].rot = 0;
			mapa[j].ptr = 0x03A0;
			mapa[j].update = 0;

		}
		i++;
	}


	int k; // za centralni deo


		i=2;
		j=0;
		while(j<25){
		for(k = 488+j*step; k <= 514+j*step; k++)//3
		{

			if(map[i*26 + k - (488+j*step)] == 1)
			{
				mapa[k].z = 1;
				mapa[k].rot = 0;
				mapa[k].ptr = 0x03B0;
				mapa[k].update = 0;
			}
			else if(map[i*26 + k - (488+j*step)] == 2)
			{
				mapa[k].z = 0;
				mapa[k].rot = 0;
				mapa[k].ptr = 0x0420;
				mapa[k].update = 0;
			}
			else if(map[i*26+ k - (488+j*step)] == 3)
			{
				mapa[k].z = 0;
				mapa[k].rot = 0;
				mapa[k].ptr = 0x03D0;
				mapa[k].update = 0;
			}
			else if(map[i*26+ k - (488+j*step)] == 4)
			{
				mapa[k].z = 1;
				mapa[k].rot = 0;
				mapa[k].ptr = 0x03B0;
				mapa[k].update = 0;
			}
			else if(map[i*26+ k - (488+j*step)] == 5)
			{
				mapa[k].z = 2;
				mapa[k].rot = 0;
				mapa[k].ptr = 0x03C0;
				mapa[k].update = 0;
			}
			else
			{
				mapa[k].z = 0;
				mapa[k].rot = 0;
				mapa[k].ptr = 0x0400;
				mapa[k].update = 0;
			}
		}
		i++;
		j++;
		}





	//int m; // je za desni deo ekrana
	i=0;
	while(i<27){
		for(j = 354+i*step; j <= 399+i*step; j++)//1
		{
			mapa[j].z = 0;
			mapa[j].rot = 0;
			mapa[j].ptr = 0x03A0;
			mapa[j].update = 0;
		}
		i++;
	}


	//int p; // za ostatak mape
	for(j = 2399; j <= 4800; j++)
	{
		mapa[j].z = 0;
		mapa[j].rot = 0;
		mapa[j].ptr = 0x03A0;
		mapa[j].update = 0;
	}


///////////////////////////////////////////////////////////////////////////////////

}
//fnja
void sleep(int sec){
	int i;
	for(i=0;i<=sec*10000;i++){

	}
}

//prelepo radi
void resetovanje(tank_t *tank1, tank_t *tank_ai, tank_t *tank_ai2, bullet_t *blt0, bullet_t *blt1, bullet_t *blt2){
	tank1->dir=DIR_UP;
	tank1->x=( MAP_X + MAP_W / 2 +2) * 8;
	tank1->y=( MAP_Y+2 + MAP_H - 5 ) * 8;
	tank1->destroyed=b_false;
	blt0->enabled=b_false;

	tank_ai->dir=DIR_UP;
	tank_ai->x=MAP_X * 8;
	tank_ai->y=MAP_Y * 8;
	tank_ai->destroyed=b_false;
	blt1->enabled=b_false;

	tank_ai2->dir=DIR_UP;
	tank_ai2->x=( MAP_X +20) * 8;
	tank_ai2->y=( MAP_Y ) * 8;
	tank_ai2->destroyed=b_false;
	blt2->enabled=b_false;

}
void battle_city( void )
{
	int rbm,cekaj;
	unsigned int buttons;
	unsigned int ai_dir;
	unsigned int ai_dir2;
    unsigned int title[ 10 ] = { _T, _E, _N, _K,  _O, _V, _I, _TERM };
    unsigned int game_victory[ 7 ] = { _P, _O, _B, _E, _D, _A, _TERM };
    unsigned int game_loss[ 6 ] = { _P, _O, _R, _A, _Z, _TERM };
    resetovanje(&tank1,&tank_ai,&tank_ai2,&tank1.bullet,&tank_ai.bullet,&tank_ai2.bullet);


    rbm=1;
    game_time = 0;
    game_result = RES_NONE;
    ai_dir = DIR_RIGHT;
    ai_dir2 = DIR_LEFT;
    konverzija(mape,map1);

    map_reset( mape );

    draw_string( 18, 1, title );

    tank_spawn( &tank1 );
    tank_spawn( &tank_ai );
    tank_spawn( &tank_ai2 );


    base_spawn( );

    while( 1 ) {
			if( game_time % 14 == 0 ) {
				buttons = XIo_In32( XPAR_IO_PERIPH_BASEADDR );

				if( BTN_UP( buttons ) ) {
					tank_move( mape, &tank1, &tank_ai, &tank_ai2, DIR_UP );
				} else if( BTN_DOWN( buttons ) ) {
					tank_move( mape, &tank1, &tank_ai, &tank_ai2, DIR_DOWN );
				}  else if( BTN_LEFT( buttons ) ) {
					tank_move( mape, &tank1, &tank_ai, &tank_ai2, DIR_LEFT );
				} else if( BTN_RIGHT( buttons ) ) {
					tank_move( mape, &tank1, &tank_ai, &tank_ai2, DIR_RIGHT );
				} else if( BTN_SHOOT( buttons ) ) {
					tank_fire( mape, &tank1 );
				}

				process_ai( &tank_ai,&tank_ai2, &ai_dir );
				process_ai2( &tank_ai2, &ai_dir2);

			}
			process_bullet( mape, &tank1.bullet );
			process_bullet( mape, &tank_ai.bullet );
			process_bullet( mape, &tank_ai2.bullet );

			map_update( mape );

			if( game_result == RES_VICTORY ) {
				draw_string( 1, 4, game_victory );
				rbm++;
				for(cekaj = 0; cekaj < 5000000; cekaj++);
				if(rbm==2){
					   sleep(5);
					   resetovanje(&tank1,&tank_ai,&tank_ai2,&tank1.bullet,&tank_ai.bullet,&tank_ai2.bullet);
					   game_time = 0;
					    game_result = RES_NONE;
					    ai_dir = DIR_RIGHT;
					    konverzija(mape,map2);

					    map_reset( mape );

					    draw_string( 18, 1, title );

					    tank_spawn( &tank1 );
					    tank_spawn( &tank_ai2 );
					    tank_spawn( &tank_ai );


					    base_spawn( );

				    continue;
					}
				else if(rbm == 3){
					   sleep(5);
					  resetovanje(&tank1,&tank_ai,&tank_ai2,&tank1.bullet,&tank_ai.bullet,&tank_ai2.bullet);
					  game_time = 0;
					  game_result = RES_NONE;
					   ai_dir = DIR_RIGHT;
					 konverzija(mape,map3);

					  map_reset( mape );

				    draw_string( 18, 1, title );

					 tank_spawn( &tank1 );
					 tank_spawn( &tank_ai2 );
					 tank_spawn( &tank_ai );

					  base_spawn( );

				    continue;
				}
				else if(rbm == 4){
					 sleep(5);
				    resetovanje(&tank1,&tank_ai,&tank_ai2,&tank1.bullet,&tank_ai.bullet,&tank_ai2.bullet);
					 game_time = 0;
					 game_result = RES_NONE;
					   ai_dir = DIR_RIGHT;
					 konverzija(mape,map4);

					  map_reset( mape );

					  draw_string( 18, 1, title );

					 tank_spawn( &tank1 );
					 tank_spawn( &tank_ai2 );
					 tank_spawn( &tank_ai );

						  base_spawn( );

						  continue;
				}
				else if(rbm == 5){
				 sleep(5);
				 resetovanje(&tank1,&tank_ai,&tank_ai2,&tank1.bullet,&tank_ai.bullet,&tank_ai2.bullet);
				 game_time = 0;
				 game_result = RES_NONE;
				  ai_dir = DIR_RIGHT;
				 konverzija(mape,map5);

				  map_reset( mape );

				 draw_string( 18, 1, title );

				 tank_spawn( &tank1 );
				tank_spawn( &tank_ai );

				 base_spawn( );

				  continue;
				}

				else if(rbm == 6){
				 sleep(5);
				 resetovanje(&tank1,&tank_ai,&tank_ai2,&tank1.bullet,&tank_ai.bullet,&tank_ai2.bullet);
				 game_time = 0;
				 game_result = RES_NONE;
				  ai_dir = DIR_RIGHT;
				 konverzija(mape,map6);

				  map_reset( mape );

				 draw_string( 18, 1, title );

				 tank_spawn( &tank1 );
				tank_spawn( &tank_ai );

				 base_spawn( );

				  continue;
				}
				else if(rbm == 7){
				 sleep(5);
				 resetovanje(&tank1,&tank_ai,&tank_ai2,&tank1.bullet,&tank_ai.bullet,&tank_ai2.bullet);
				 game_time = 0;
				 game_result = RES_NONE;
				  ai_dir = DIR_RIGHT;
				 konverzija(mape,map7);

				  map_reset( mape );

				 draw_string( 18, 1, title );

				 tank_spawn( &tank1 );
				tank_spawn( &tank_ai );

				 base_spawn( );

				  continue;
				}
				else if(rbm == 8){
					sleep(5);
									 resetovanje(&tank1,&tank_ai,&tank_ai2,&tank1.bullet,&tank_ai.bullet,&tank_ai2.bullet);
					rbm=1;
					    game_time = 0;
					    game_result = RES_NONE;
					    ai_dir = DIR_RIGHT;
					    ai_dir2 = DIR_LEFT;
					    konverzija(mape,map1);

					    map_reset( mape );

					    draw_string( 18, 1, title );

					    tank_spawn( &tank1 );
					    tank_spawn( &tank_ai );
					    tank_spawn( &tank_ai2 );


					    base_spawn( );

								  continue;
								}


			} else if( game_result == RES_LOSS ) {
				draw_string( 1, 4, game_loss );
				rbm=1;
				for(cekaj = 0; cekaj < 5000000; cekaj++);

				if(rbm == 1){
					 game_time = 0;
					 resetovanje(&tank1,&tank_ai,&tank_ai2,&tank1.bullet,&tank_ai.bullet,&tank_ai2.bullet);
					    game_result = RES_NONE;
					    ai_dir = DIR_RIGHT;
					    konverzija(mape,map1);

					    map_reset( mape );

					    draw_string( 18, 1, title );

					    tank_spawn( &tank1 );
					    tank_spawn( &tank_ai2 );
					    tank_spawn( &tank_ai );

					    base_spawn( );
					    continue;
				}
			}

			game_time++;

    }
}
