import { NavigationContainer } from "@react-navigation/native";
import { createNativeStackNavigator } from "@react-navigation/native-stack";
import React from "react";
import Home from "./pages/Home";
import Admin from "./pages/Admin";

const Stack = createNativeStackNavigator();

export default function App() {
  return (
    <NavigationContainer>
      <Stack.Navigator>
        <Stack.Screen
          name="Home"
          component={Home}></Stack.Screen>
        <Stack.Screen
          name="Admin"
          component={Admin}></Stack.Screen>
      </Stack.Navigator>
    </NavigationContainer>
  );
} 