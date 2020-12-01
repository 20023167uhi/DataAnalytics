from mesa.visualization.modules import CanvasGrid
from mesa.visualization.ModularVisualization import ModularServer, VisualizationElement

import numpy as np

from money_model import MoneyModel

"""Running a visualization using Mesa Package and an local server"""
def agent_portrayal(agent):
    portrayal = {
        "Shape": "circle",
        "Color": "red",
        "Filled": "true",
        "Layer": 0,
        "r": 0.5,
    }
    return portrayal

"""Creating a custom visualization"""
class HistogramModule(VisualizationElement):
    package_includes = ["Chart.min.js"]
    local_includes = ["HistogramModule.js"]

    def __init__(self, bins, canvas_height, canvas_width):
        self.canvas_height = canvas_height
        self.canvas_width = canvas_width
        self.bins = bins
        new_element = "new HistogramModule({}, {}, {})"
        new_element = new_element.format(
            bins,
            canvas_width,
            canvas_height,
        )
        self.js_code = "elements.push(" + new_element + ");"

    def render(self, model):
        wealth_vals = [agent.wealth for agent in model.schedule.agents]
        hist = np.histogram(wealth_vals, bins=self.bins)[0]
        return [int(x) for x in hist]


grid = CanvasGrid(agent_portrayal, 10, 10, 500, 500)
histogram = HistogramModule(list(range(10)), 200, 500)

server = ModularServer(
    MoneyModel,
    [grid],
    "Money Model",
    {"N": 100, "width": 10, "height": 10},
)
server.port = 8521 # This is the default value
# server.launch()
