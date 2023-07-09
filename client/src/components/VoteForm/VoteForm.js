

export default function VoteForm() {
    const onSubmit = (e) => {
        e.preventDefault();
    } 
    
    return (
        <div className='vote-form'>
            <form onSubmit={onSubmit}>
                <select>
                    <option>Select Candidate</option>
                </select>
            </form>
        </div>
     );
}