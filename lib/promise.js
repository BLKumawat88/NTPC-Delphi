 function  getEmpList() {
    return   new Promise((res,rej)=>{
    isDataAvailable =false;
    for( i=0;i<100;i++){
        if(100){
            isDataAvailable=true;
        }
    }
    if(isDataAvailable){
        setTimeout(()=>{
            res({"code":200,"EmpList":[{"emp_code":1001,"emp_name":"BL Kuamwat"}]})
                    },3000);
    }else{
        rej({"code":400,"msg":"No user found"});
    }

    },);
}

// getEmpList().then((data)=> console.log(`Got Data ${JSON.stringify(data)}`)).catch((error)=>{
//     console.log(`Error ${JSON.stringify(error)}`);
// });

async function  abc(){
    try{
     var data =   await getEmpList();
     console.log(`Got Data ${JSON.stringify(data)}`)
    }catch(error){
        console.log(`Error ${error}`);
    }
}

abc();



