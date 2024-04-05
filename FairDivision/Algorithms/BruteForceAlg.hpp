//
//  BruteForceAlg.hpp
//  FairDivision
//
//  Created by Anushka Sankaran on 3/22/24.
//

#ifndef BruteForceAlg_hpp
#define BruteForceAlg_hpp

#include <stdio.h>
#include <iostream>
#include <vector>
#include <cmath>

std::vector<std::vector<int>> generate_owner_vectors(int num_agents, int num_items);

// Function to generate all allocations
std::vector<std::vector<std::vector<int>>> generate_all_allocations(int num_agents, int num_items);

// Function to get maximum Nash welfare
std::pair<std::vector<std::vector<int>>, double> get_max_nash_welfare(int num_agents, int num_items, const std::vector<std::vector<int>>& valuation_matrix);

#endif /* BruteForceAlg_hpp */
