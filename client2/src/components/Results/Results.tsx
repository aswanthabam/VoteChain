import React from 'react';
import {Text, View, StyleSheet} from 'react-native';

const TableStyle = StyleSheet.create({
  borderColor:'black',
  borderStyle:'solid',
  borderWidth:1,
  flex:1,
  padding:5,
  alignItems:'center'
});
type ResultsProp = {
  candidates: Array
}
const Results = (props: ResultsProp) => {
  return (
    <View style={{width:'100%',padding:20,alignItems:'center'}}>
      <Text style={{fontSize:20,marginBottom:10,fontWeight:800}}>Results</Text>
      <View style={{
          flexDirection:'row',
          justifyContent:'space-between'
        }}>
        <View style={TableStyle}><Text style={{fontWeight:800}}>Name</Text></View>
        <View style={TableStyle}><Text style={{fontWeight:800}}>Votes</Text></View>
      </View>
      {
        props.candidates.map(can=>(
          <View style={{
            flexDirection:'row',
            justifyContent:'space-between'
          }}>
            <View style={TableStyle}><Text>{can.name}</Text></View>
            <View style={TableStyle}><Text>{can.votes}</Text></View>
          </View>
        ))
      }
    </View>
  );
};

export default Results;
