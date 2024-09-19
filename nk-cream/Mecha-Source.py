import pygame.mixer
from pynput import keyboard
import os

pygame.mixer.init()

def update_window_title():
    pass

sounds_dir = '.'
sounds = {
    'a': 'a.wav',
    'b': 'b.wav',
    'backspace': 'backspace.wav',
    'c': 'c.wav',
    'caps lock': 'caps lock.wav',
    'd': 'd.wav',
    'e': 'e.wav',
    'enter': 'enter.wav',
    'f': 'f.wav',
    'g': 'g.wav',
    'h': 'h.wav',
    'i': 'i.wav',
    'j': 'j.wav',
    'k': 'k.wav',
    'l': 'l.wav',
    'm': 'm.wav',
    'n': 'n.wav',
    'o': 'o.wav',
    'p': 'p.wav',
    'q': 'q.wav',
    'r': 'r.wav',
    's': 's.wav',
    'shift': 'shift.wav',
    'space': 'space.wav',
    't': 't.wav',
    'tab': 'tab.wav',
    'u': 'u.wav',
    'v': 'v.wav',
    'w': 'w.wav',
    'x': 'x.wav',
    'y': 'y.wav',
    'z': 'z.wav',
    '[': '[.wav',
    ']': '].wav'
}

sound_objects = {}
for key, filename in sounds.items():
    try:
        sound_objects[key] = pygame.mixer.Sound(os.path.join(sounds_dir, filename))
        sound_objects[key].set_volume(1.0)
    except pygame.error:
        print(f"Could not load {filename}.")

pressed_keys = set()
def play_sound(key):
    key_str = str(key).strip("'")
    if key_str in sound_objects:
        sound_objects[key_str].play(maxtime=5000)

def on_press(key):
    try:
        if hasattr(key, 'char') and key.char:
            key_str = key.char.lower()
            if key_str not in pressed_keys:
                pressed_keys.add(key_str)
                play_sound(key_str)
        elif key == keyboard.Key.backspace:
            if 'backspace' not in pressed_keys:
                pressed_keys.add('backspace')
                play_sound('backspace')
        elif key == keyboard.Key.caps_lock:
            if 'caps lock' not in pressed_keys:
                pressed_keys.add('caps lock')
                play_sound('caps lock')
        elif key == keyboard.Key.enter:
            if 'enter' not in pressed_keys:
                pressed_keys.add('enter')
                play_sound('enter')
        elif key == keyboard.Key.shift:
            if 'shift' not in pressed_keys:
                pressed_keys.add('shift')
                play_sound('shift')
        elif key == keyboard.Key.space:
            if 'space' not in pressed_keys:
                pressed_keys.add('space')
                play_sound('space')
        elif key == keyboard.Key.tab:
            if 'tab' not in pressed_keys:
                pressed_keys.add('tab')
                play_sound('tab')
    except Exception as e:
        print(f"Error: {e}")

def on_release(key):
    try:
        if hasattr(key, 'char') and key.char:
            key_str = key.char.lower()
            if key_str in pressed_keys:
                pressed_keys.remove(key_str)
        elif key == keyboard.Key.backspace:
            if 'backspace' in pressed_keys:
                pressed_keys.remove('backspace')
        elif key == keyboard.Key.caps_lock:
            if 'caps lock' in pressed_keys:
                pressed_keys.remove('caps lock')
        elif key == keyboard.Key.enter:
            if 'enter' in pressed_keys:
                pressed_keys.remove('enter')
        elif key == keyboard.Key.shift:
            if 'shift' in pressed_keys:
                pressed_keys.remove('shift')
        elif key == keyboard.Key.space:
            if 'space' in pressed_keys:
                pressed_keys.remove('space')
        elif key == keyboard.Key.tab:
            if 'tab' in pressed_keys:
                pressed_keys.remove('tab')
    except Exception as e:
        print(f"Error: {e}")

def print_remade_Vibes():
    remade_Vibes = """
 Mecha-Vibes Remade    """
    
    print(remade_Vibes)

def display_credit():
    print("\nPre-Made Mecha Vibes More Sounds Coming Soon!")

def main():
    print_remade_Vibes()
    display_credit()
    update_window_title()

    with keyboard.Listener(on_press=on_press, on_release=on_release) as listener:
        listener.join()

if __name__ == "__main__":
    main()
