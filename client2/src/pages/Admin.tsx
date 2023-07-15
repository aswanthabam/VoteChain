import AsyncStorage from "@react-native-async-storage/async-storage";
import React, { useEffect, useState } from "react";
import { Button, StyleSheet, Text, TextInput, View } from "react-native";

const textStyle = StyleSheet.create({
  borderColor:'black'  ,
  borderWidth:1,
  marginBottom:10

});

export default function Admin ({navigation, route}) {
  useEffect(()=>{
    async function init() {
      setHelperUrl(await AsyncStorage.getItem("helperServerUrl") || "http://192.168.18.2:3131");
      setBlockchainUrl(await AsyncStorage.getItem("blockchainUrl") || "http://192.168.18.2:7545");
    }
    init();
  },[])
  const [helperUrl,setHelperUrl] = useState();
  const [blockchainUrl,setBlockchainUrl] = useState();

  const saveValues = () => {
    console.log("Saving config");
    console.log(helperUrl);
    console.log(blockchainUrl);
    AsyncStorage.setItem("helperServerUrl",helperUrl);
    AsyncStorage.setItem("blockchainUrl",blockchainUrl);
  };

  return (
    <View style={{padding:20}}>
      <Text>Helper Server URL</Text>
      <TextInput
        style={textStyle}
        value={helperUrl}
        onChangeText={setHelperUrl}
        placeholder="Helper Server URL"></TextInput>
      <Text>Blockchain URL</Text>
      <TextInput
        style={textStyle}
        value={blockchainUrl}
        onChangeText={setBlockchainUrl}
        placeholder="Blockchain URL"></TextInput>
      <Button
        title="Save"
        onPress={saveValues}
        color="#ccc"></Button>
    </View>
  )
}