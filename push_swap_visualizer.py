import os
import pygame
import sys
import time

def is_sorted(lst):
    return all(lst[i] >= lst[i+1] for i in range(len(lst)-1))

class Stack:
    def __init__(self):
        self.items = []

    def push(self, item):
        self.items.append(item)

    def pop(self):
        if not self.is_empty():
            return self.items.pop()
        return None

    def is_empty(self):
        return len(self.items) == 0

    def size(self):
        return len(self.items)

    def get_items(self):
        return self.items

class StackVisualizer:
    def __init__(self, numbers):
        self.stack_a = Stack()
        self.stack_b = Stack()
        for num in reversed(numbers):
            self.stack_a.push(num)

        self.operation_mapping = {
            'sa': self.swap_a,
            'sb': self.swap_b,
            'ss': self.swap_both,
            'pa': self.push_a,
            'pb': self.push_b,
            'ra': self.rotate_a,
            'rb': self.rotate_b,
            'rr': self.rotate_both,
            'rra': self.reverse_rotate_a,
            'rrb': self.reverse_rotate_b,
            'rrr': self.reverse_rotate_both
        }

        pygame.init()
        self.screen_width = 1000
        self.screen_height = 600
        self.screen = pygame.display.set_mode((self.screen_width, self.screen_height))
        self.base_stack_height = self.screen_height // 2

        script_dir = os.path.dirname(os.path.realpath(__file__))
        image_path = os.path.join(script_dir, 'images', 'Builder_bee_rad.jpg')

        self.background_image = pygame.image.load(image_path)
        self.background_image = pygame.transform.scale(self.background_image, (self.screen_width, self.screen_height))

    def swap_a(self):
        if self.stack_a.size() >= 2:
            top = self.stack_a.pop()
            second = self.stack_a.pop()
            self.stack_a.push(top)
            self.stack_a.push(second)

    def swap_b(self):
        if self.stack_b.size() >= 2:
            top = self.stack_b.pop()
            second = self.stack_b.pop()
            self.stack_b.push(top)
            self.stack_b.push(second)

    def swap_both(self):
        self.swap_a()
        self.swap_b()

    def push_a(self):
        if not self.stack_b.is_empty():
            self.stack_a.push(self.stack_b.pop())

    def push_b(self):
        if not self.stack_a.is_empty():
            self.stack_b.push(self.stack_a.pop())

    def rotate_a(self):
        if self.stack_a.size() > 0:
            top = self.stack_a.pop()
            self.stack_a.items.insert(0, top)

    def rotate_b(self):
        if self.stack_b.size() > 0:
            top = self.stack_b.pop()
            self.stack_b.items.insert(0, top)

    def rotate_both(self):
        self.rotate_a()
        self.rotate_b()

    def reverse_rotate_a(self):
        if self.stack_a.size() > 0:
            bottom = self.stack_a.items.pop(0)
            self.stack_a.push(bottom)

    def reverse_rotate_b(self):
        if self.stack_b.size() > 0:
            bottom = self.stack_b.items.pop(0)
            self.stack_b.push(bottom)

    def reverse_rotate_both(self):
        self.reverse_rotate_a()
        self.reverse_rotate_b()

    def draw_stack(self, stack, offset_x, base_height, is_stack_a=True):
        items = stack.get_items()
        space_between_boxes = 1
        num_items = len(items)
        total_space = space_between_boxes * (num_items - 1)
        all_numbers = self.stack_a.get_items() + self.stack_b.get_items()  
        sorted_numbers = sorted(all_numbers)
        total_height = self.screen_height - 10
        height_step = total_height / (len(all_numbers) - 1) if len(all_numbers) > 1 else total_height

        
        total_width_per_stack = self.screen_width // 2 - total_space
        box_width = total_width_per_stack // num_items

        
        color = (0, 255, 0) if is_stack_a else (255, 0, 0)

        for i, item in enumerate(items):

            position = sorted_numbers.index(item)
            rect_height = position * height_step + 5

            
            x_position = (offset_x + i * (box_width + space_between_boxes)) if is_stack_a else (self.screen_width // 2 + offset_x + i * (box_width + space_between_boxes))

            pygame.draw.rect(self.screen, color, (
                x_position, self.screen_height - rect_height, box_width, rect_height))



    def draw(self):
        self.screen.fill((255, 255, 255))
        self.screen.blit(self.background_image, (0, 0))
        base_height = self.base_stack_height
    
        
        if not self.stack_a.is_empty():
            self.draw_stack(self.stack_a, 10, base_height, is_stack_a=True)
    
        
        if not self.stack_b.is_empty():
            self.draw_stack(self.stack_b, 10, base_height, is_stack_a=False)
    
        pygame.display.flip()




    def run(self, operations, output_file='sort_results.txt'):
        running = True
        num_elements = len(self.stack_a.get_items()) + len(self.stack_b.get_items())
        wait_time = max(0.01, min(1, 1.0 / max(1, num_elements)))
        for operation in operations:
            self.handle_events()
        
            if operation in self.operation_mapping:
                self.operation_mapping[operation]()
                self.draw()
                time.sleep(wait_time)

        GREEN = '\033[92m'
        RED = '\033[91m'
        RESET = '\033[0m'

        sorted_status = is_sorted(self.stack_a.get_items()) and not self.stack_b.get_items()

        with open(output_file, 'a') as file:
            if sorted_status:
                file.write(GREEN + '[OK]' + RESET + '\n')
            else:
                file.write(RED + '[KO]' + RESET + '\n')

        time.sleep(1)
        pygame.quit()
        sys.exit()


    def handle_events(self):
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                pygame.quit()
                sys.exit()


if __name__ == "__main__":

    number_sequence = sys.argv[1]
    numbers = list(map(int, number_sequence.split(' ')))


    operations = sys.stdin.read().strip().split('\n')

    visualizer = StackVisualizer(numbers)
    visualizer.run(operations)
