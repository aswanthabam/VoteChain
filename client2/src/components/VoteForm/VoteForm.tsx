import React, { useState } from "react";
import {Picker} from '@react-native-picker/picker';
import { Button, Text, View } from "react-native";

type VoteFormProps = {
  vote: Function,
  candidates: Array
};
export default function VoteForm (props: VoteFormProps) {
  const [selectedCandidate, setSelectedCandidate] = useState(null);
  return (
    <View>
      <Text>Cast your Vote</Text>
      <Picker
        selectedValue={selectedCandidate}
        onValueChange={(itemValue, itemIndex) =>
          setSelectedCandidate(itemValue)
        }>
        {
          props.candidates.map(can => (
            <Picker.Item label={can.name} value={can.key}></Picker.Item>
          ))
        }
      </Picker> 
      {selectedCandidate && <Button
        onPress={(async ()=>{props.vote(selectedCandidate)})}
        title="Vote"
        color="#841584"
        accessibilityLabel="Vote Button"
      />}
    </View>
  )
}