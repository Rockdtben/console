// Mob Overlays Indexes
/// Total number of layers for mob overlays
/// KEEP THIS UP-TO-DATE OR SHIT WILL BREAK
/// Also consider updating layers_to_offset
#define TOTAL_LAYERS 34
/// Mutations layer - Tk headglows, cold resistance glow, etc
#define MUTATIONS_LAYER 34
/// Mutantrace features (tail when looking south) that must appear behind the body parts
#define BODY_BEHIND_LAYER 33
/// Layer for bodyparts that should appear behind every other bodypart - Mostly, legs when facing WEST or EAST
#define BODYPARTS_LOW_LAYER 32
/// Layer for most bodyparts, appears above BODYPARTS_LOW_LAYER and below BODYPARTS_HIGH_LAYER
#define BODYPARTS_LAYER 31
/// Mutantrace features (snout, body markings) that must appear above the body parts
#define BODY_ADJ_LAYER 30
/// Underwear, undershirts, socks, eyes, lips(makeup)
#define BODY_LAYER 29
/// Mutations that should appear above body, body_adj and bodyparts layer (e.g. laser eyes)
#define FRONT_MUTATIONS_LAYER 28
/// Damage indicators (cuts and burns)
#define DAMAGE_LAYER 27
/// Jumpsuit clothing layer
#define UNIFORM_LAYER 26
/// ID card layer
#define ID_LAYER 25
/// ID card layer (might be deprecated)
#define ID_CARD_LAYER 24
/// Layer for bodyparts that should appear above every other bodypart - Currently only used for hands
#define BODYPARTS_HIGH_LAYER 23
/// Gloves layer
#define GLOVES_LAYER 22
/// Shoes layer
#define SHOES_LAYER 21
/// Layer for masks that are worn below ears and eyes (like Balaclavas) (layers below hair, use flagsinv=HIDEHAIR as needed)
#define LOW_FACEMASK_LAYER 20
/// Ears layer (Spessmen have ears? Wow)
#define EARS_LAYER 19
/// Suit layer (armor, coats, etc.)
#define SUIT_LAYER 18
/// Glasses layer
#define GLASSES_LAYER 17
/// Belt layer
#define BELT_LAYER 16 //Possible make this an overlay of somethign required to wear a belt?
/// Suit storage layer (tucking a gun or baton underneath your armor)
#define SUIT_STORE_LAYER 15
/// Neck layer (for wearing ties and bedsheets)
#define NECK_LAYER 14
/// Back layer (for backpacks and equipment on your back)
#define BACK_LAYER 13
/// Hair layer (mess with the fro and you got to go!)
#define HAIR_LAYER 12 //TODO: make part of head layer?
/// Facemask layer (gas masks, breath masks, etc.)
#define FACEMASK_LAYER 11
/// Head layer (hats, helmets, etc.)
#define HEAD_LAYER 10
/// Handcuff layer (when your hands are cuffed)
#define HANDCUFF_LAYER 9
/// Legcuff layer (when your feet are cuffed)
#define LEGCUFF_LAYER 8
/// Hands layer (for the actual hand, not the arm... I think?)
#define HANDS_LAYER 7
/// Body front layer. Usually used for mutant bodyparts that need to be in front of stuff (e.g. cat ears)
#define BODY_FRONT_LAYER 6
/// Special body layer that actually require to be above the hair (e.g. lifted welding goggles)
#define ABOVE_BODY_FRONT_GLASSES_LAYER 5
/// Special body layer for the rare cases where something on the head needs to be above everything else (e.g. flowers)
#define ABOVE_BODY_FRONT_HEAD_LAYER 4
/// Bleeding wound icons
#define WOUND_LAYER 3
/// Blood cult ascended halo layer, because there's currently no better solution for adding/removing
#define HALO_LAYER 2
/// Fire layer when you're on fire
#define FIRE_LAYER 1
