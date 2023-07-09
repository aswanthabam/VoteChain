import {useEffect,useState} from 'react';
import { Web3 } from 'web3';
export default function Results() {
    useEffect(()=>{
        // console.log(Web3);

    },[]);
    return (
        <div className='result'>
            <table>
                <th>
                    <td>Candidate</td>
                    <td>Votes</td>
                </th>
            </table>
        </div>
    )
}