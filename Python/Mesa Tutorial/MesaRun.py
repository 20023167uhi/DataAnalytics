import matplotlib.pyplot as plt

from mesa.batchrunner import BatchRunner

import numpy as np

from money_model import *

""" Single run of the agents to show the process """
# model = MoneyModel(10)
# for i in range(10):
#     model.step()

# agent_wealth = [a.wealth for a in model.schedule.agents]
# plt.hist(agent_wealth)
# plt.show()

"""Cycling the agents through multiple iterations to show where the money is going"""
# all_wealth = []
# # Running the model 100 times, each model executing 10 steps 
# for j in range(100):
#     # Run the model
#     print(f"Model run number {j+1}")
#     model = MoneyModel(10)
#     for i in range(10):
#         model.step()
    
#     # Storing the results
#     for agent in model.schedule.agents:
#         all_wealth.append(agent.wealth)

# plt.hist(all_wealth, bins=range(max(all_wealth)+1))
# plt.show()

"""Running a 2x2 instance of the matrix to show how neighbors are affected"""
# model = MoneyModel(50, 10, 10)
# for i in range(100):
#     model.step()

# agent_counts = np.zeros((model.grid.width, model.grid.height))
# for cell in model.grid.coord_iter():
#     cell_content, x, y = cell
#     agent_count = len(cell_content)
#     agent_counts[x][y] = agent_count
# plt.imshow(agent_counts, interpolation='nearest')
# plt.colorbar()
# plt.show()

"""Running Data Collection and the Gini function to show a plot of income disparity over steps"""
# model = MoneyModel(50, 10, 10)
# for i in range(100):
#     model.step()
# agent_wealth = model.datacollector.get_agent_vars_dataframe()
# print(f"""
#     Grabbing the Agent wealth data

#     {agent_wealth.head()}
#     """)
# gini = model.datacollector.get_model_vars_dataframe()
# gini.plot()
# plt.show()
# end_wealth = agent_wealth.xs(99, level="Step")["Wealth"]
# end_wealth.hist(bins=range(agent_wealth.Wealth.max()+1))
# plt.show()
# one_agent_wealth = agent_wealth.xs(14, level="AgentID")
# one_agent_wealth.Wealth.plot()
# plt.show()

"""
    Running app as a batch command. 
    This will plot a scatter chart of 5 points per column as per iterations for each gini result.
"""
fixed_params = {
    "width": 10,
    "height": 10,
}
variable_params = {"N": range(10, 500, 10)}

batch_run = BatchRunner(
    MoneyModel,
    variable_params,
    fixed_params,
    iterations=5,
    max_steps=50,
    model_reporters={"Gini": compute_gini},
)
batch_run.run_all()
run_data = batch_run.get_model_vars_dataframe()
print(f"""The head of the data is 

    {run_data.head()}
""")
plt.scatter(run_data.N, run_data.Gini)
plt.show()